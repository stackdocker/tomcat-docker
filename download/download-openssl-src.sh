#!/bin/bash

working_dir=`pwd`

download_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

download_dir+="/openssl"

mkdir -p $download_dir

openssl_url=https://www.openssl.org/source/openssl-1.0.2j.tar.gz
# openssl_url=https://www.openssl.org/source/openssl-1.1.0c.tar.gz

curl -jkSL $openssl_url -O $download_dir/${openssl_url##*/}

# github_openssl_url=https://github.com/openssl/openssl/archive/OpenSSL_1_0_2j.tar.gz
github_openssl_url=https://github.com/openssl/openssl/archive/OpenSSL_1_1_0c.tar.gz

curl -jkSL $github_openssl_url -O $download_dir/${github_openssl_url##*/}

cd $working_dir