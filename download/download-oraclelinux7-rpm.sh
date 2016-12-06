#!/bin/bash

set -e

working_dir=`pwd`

download_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

download_dir+="/oraclelinux7/rpm"

mkdir -p $download_dir

if [ -e /bin/docker -o -e /usr/bin/docker -o -e /usr/local/bin/docker ]; then
    if [[ $(docker version -f {{.Client.Version}}) =~ [1-9]\.[1-9]+\.[1-9]+ ]]; then

install_pkgs="
    apr-devel \
	openssl-devel \
	gcc \
	make \
	perl \
"

docker run -t --rm -v $download_dir:/tmp/download oraclelinux:7.3 \
    yum --downloadonly --downloaddir=/tmp/download install apr-devel openssl-devel gcc make perl

    fi
else

###basearch=x86_64

### [ol7_latest]
### baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/latest/$basearch/
baseurl=https://public-yum.oracle.com/repo/OracleLinux/OL7/latest

install_rpms=" \
	apr-1.4.8-3.el7.x86_64.rpm \
	apr-devel-1.4.8-3.el7.x86_64.rpm \
	cpp-4.8.5-11.el7.x86_64.rpm \
	gcc-4.8.5-11.el7.x86_64.rpm \
	glibc-devel-2.17-157.el7.x86_64.rpm \
	glibc-headers-2.17-157.el7.x86_64.rpm \
	groff-base-1.22.2-8.el7.x86_64.rpm \
	kernel-headers-3.10.0-514.el7.x86_64.rpm \
	keyutils-libs-devel-1.5.8-3.el7.x86_64.rpm \
	krb5-devel-1.14.1-26.el7.x86_64.rpm \
	libcom_err-devel-1.42.9-9.el7.x86_64.rpm \
	libgomp-4.8.5-11.el7.x86_64.rpm \
	libkadm5-1.14.1-26.el7.x86_64.rpm \
	libmpc-1.0.1-3.el7.x86_64.rpm \
	libselinux-devel-2.5-6.el7.x86_64.rpm \
	libsepol-devel-2.5-6.el7.x86_64.rpm \
	libverto-devel-0.2.5-4.el7.x86_64.rpm \
	make-3.82-23.el7.x86_64.rpm \
	mpfr-3.1.1-4.el7.x86_64.rpm \
	openssl-devel-1.0.1e-60.el7.x86_64.rpm \
	pcre-devel-8.32-15.el7_2.1.x86_64.rpm \
	perl-5.16.3-291.el7.x86_64.rpm \
	perl-Carp-1.26-244.el7.noarch.rpm \
	perl-Encode-2.51-7.el7.x86_64.rpm \
	perl-Exporter-5.68-3.el7.noarch.rpm \
	perl-File-Path-2.09-2.el7.noarch.rpm \
	perl-File-Temp-0.23.01-3.el7.noarch.rpm \
	perl-Filter-1.49-3.el7.x86_64.rpm \
	perl-Getopt-Long-2.40-2.el7.noarch.rpm \
	perl-HTTP-Tiny-0.033-3.el7.noarch.rpm \
	perl-PathTools-3.40-5.el7.x86_64.rpm \
	perl-Pod-Escapes-1.04-291.el7.noarch.rpm \
	perl-Pod-Perldoc-3.20-4.el7.noarch.rpm \
	perl-Pod-Simple-3.28-4.el7.noarch.rpm \
	perl-Pod-Usage-1.63-3.el7.noarch.rpm \
	perl-Scalar-List-Utils-1.27-248.el7.x86_64.rpm \
	perl-Socket-2.010-4.el7.x86_64.rpm \
	perl-Storable-2.45-3.el7.x86_64.rpm \
	perl-Text-ParseWords-3.29-4.el7.noarch.rpm \
	perl-Time-HiRes-1.9725-3.el7.x86_64.rpm \
	perl-Time-Local-1.2300-2.el7.noarch.rpm \
	perl-constant-1.27-2.el7.noarch.rpm \
	perl-libs-5.16.3-291.el7.x86_64.rpm \
	perl-macros-5.16.3-291.el7.x86_64.rpm \
	perl-parent-0.225-244.el7.noarch.rpm \
	perl-podlators-2.5.1-3.el7.noarch.rpm \
	perl-threads-1.87-4.el7.x86_64.rpm \
	perl-threads-shared-1.43-6.el7.x86_64.rpm \
	zlib-devel-1.2.7-17.el7.x86_64.rpm \
" 

for i in $install_rpms; do
    [ ! -f "$download_dir/$i" ] && curl -jkSL "$baseurl/getPackage/$i" -o "$download_dir/$i";
done

fi

cd $working_dir


















