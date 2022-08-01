package main

import (
	"crypto/tls"
	"fmt"
	"log"
	"net/http"
	"time"
)

const (
	// In the absence of an application profile standard specifying otherwise,
	// the maximum validity period is set to 7 days.
	dcMaxTTLSeconds = 60 * 60 * 24 * 7
	dcMaxTTL        = time.Duration(dcMaxTTLSeconds * time.Second)
)

func timeHandler(w http.ResponseWriter, r *http.Request) {
	tm := time.Now().Format(time.RFC1123)
	w.Write([]byte(fmt.Sprintf("Did the handshake use KEMTLS?: %v.\n", r.TLS.DidKEMTLS)))
	w.Write([]byte("The current time is: " + tm))
}

func main() {
	serverCert, err := tls.LoadX509KeyPair(
		"localhost.crt",
		"localhost.key",
	)
	if err != nil {
		log.Fatal(err)
	}
	dc, priv, err := tls.NewDelegatedCredential(&serverCert, tls.KEMTLSWithKyber512, dcMaxTTL, false)
	if err != nil {
		log.Fatalf("NewDelegatedCredential: %v", err)
	}
	serverCert.DelegatedCredentials = append(serverCert.DelegatedCredentials, tls.DelegatedCredentialPair{dc, priv})
	config := &tls.Config{
		MinVersion: tls.VersionTLS13,
		Certificates: []tls.Certificate{
			serverCert,
		},
		CurvePreferences:           []tls.CurveID{tls.Kyber512},
		SupportDelegatedCredential: true,
		KEMTLSEnabled:              true,
	}
	mux := http.NewServeMux()
	mux.HandleFunc("/", timeHandler)

	server := http.Server{
		Addr:      ":4433",
		Handler:   mux,
		TLSConfig: config,
	}
	server.ListenAndServeTLS("", "")
}
