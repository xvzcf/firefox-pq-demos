# Firefox-Go server KEMTLS Demo

1. Run `build.sh`. Keep the default `mozilla-unified` as the source directory, and when asked to choose which version of Firefox to build, choose option 2: `Firefox for Desktop`.

2. Start the Go KEMTLS server by running: `./cf-pq-kemtls/bin/go run server.go`

3. Start Firefox by running `./mozilla-unified/mach run`

4. In Firefox, go to `about:config` and set `network.http.http2.enforce-tls-profile` to `false`.

5. Load `https://localhost:4433` in Firefox.
