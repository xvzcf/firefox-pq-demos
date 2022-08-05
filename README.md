# Firefox PQ Demos

0. Set `DO_KEMTLS` in `build.sh` according to whether you want Firefox to do KEMTLS with Kyber512 or TLS 1.3 with X25519+Kyber512

1. Run `build.sh`. Keep the default `mozilla-unified` as the source directory, and when asked to choose which version of Firefox to build, choose option 2: `Firefox for Desktop`.

2. Start Firefox by running `./mozilla-unified/mach run`

3. In Firefox, go to `about:config` and set `network.http.http2.enforce-tls-profile` to `false`.

4. (If doing KEMTLS) Start the Go KEMTLS server by running: `./cf-go/bin/go run server.go`, and then load `https://localhost:4433` in Firefox.

5. Load `https://pq.cloudflareresearch.com`.
