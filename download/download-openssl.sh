#!/bin/bash

working_dir=`pwd`

download_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

download_dir+="/openssl"

mkdir -p $download_dir

openssl_url=https://www.openssl.org/source/openssl-1.0.2j.tar.gz

# curl -jkSL $openssl_url -O $download_dir/${openssl_url##*/}

cd $working_dir