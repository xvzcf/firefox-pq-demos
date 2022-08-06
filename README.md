# TLS 1.3 With X25519+Kyber512 in Firefox

(For the KEMTLS demo, switch to the `kemtls` branch.)

1. Run `build.sh`. Keep the default `mozilla-unified` as the source directory, and when asked to choose which version of Firefox to build, choose option 2: `Firefox for Desktop`.

2. Start Firefox by running `./mozilla-unified/mach run`

3. In Firefox, load `https://pq.cloudflareresearch.com`.
