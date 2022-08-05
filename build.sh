#!/bin/bash
set -e

ROOTDIR=$(pwd)

DO_KEMTLS=false

if [ "${DO_KEMTLS}" = true ] ; then
    NSS_PATCH=nss-kemtls-patch
    FIREFOX_PATCH=firefox-patch
else
    NSS_PATCH=nss-hybrid-pq-patch
    FIREFOX_PATCH=firefox-hybrid-pq-patch
fi

# Clean up from previous run, if any
rm -f bootstrap.py
rm -rf mozilla-unified
rm -rf cf-go

# Build Firefox
sudo apt-get install curl python3 python3-dev python3-pip mercurial git

curl https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py -O
python3 bootstrap.py --no-system-changes

hg update -R mozilla-unified -r 698364:5a3f8ede374b

git apply --directory=mozilla-unified/security/nss "${NSS_PATCH}"
git apply --directory=mozilla-unified "${FIREFOX_PATCH}"
./mozilla-unified/mach build

# Build CF's fork of Go containing the KEMTLS implementation
if [ "${DO_KEMTLS}" = true ] ; then
    cd "${ROOTDIR}"
    git clone --branch cf-pq-kemtls --depth 1 https://github.com/cloudflare/go cf-go
    cd cf-go/src && ./make.bash
fi
