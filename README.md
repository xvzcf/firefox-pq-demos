# KEMTLS With Kyber512 in Firefox

1. Run `build.sh`. Keep the default `mozilla-unified` as the source directory, and when asked to choose which version of Firefox to build, choose option 2: `Firefox for Desktop`.

2. Start Firefox by running `./mozilla-unified/mach run`

3. In Firefox, go to `about:config` and set `network.http.http2.enforce-tls-profile` to `false`.

4. Start the Go KEMTLS server by running: `./cf-go/bin/go run server.go`

5. Load `https://localhost:4433` in Firefox.
