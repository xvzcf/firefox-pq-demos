#!/bin/bash
set -e

ROOTDIR=$(pwd)

# Clean up from previous run, if any
rm -f bootstrap.py
rm -rf mozilla-unified
rm -rf cf-go

# Build Firefox
sudo apt-get install curl python3 python3-dev python3-pip mercurial git

curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
python3 bootstrap.py --no-system-changes
hg update -R mozilla-unified -r 698364:5a3f8ede374b

git apply --directory=mozilla-unified/security/nss nss.patch
git apply --directory=mozilla-unified firefox.patch
./mozilla-unified/mach build

# Build CF's fork of Go containing the KEMTLS implementation
cd "${ROOTDIR}"
git clone --branch cf-pq-kemtls --depth 1 https://github.com/cloudflare/go cf-go
cd cf-go/src && ./make.bash
