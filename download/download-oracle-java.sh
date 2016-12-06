#!/bin/bash -e

# curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie; " http://download.oracle.com/otn-pub/java/jdk/7u80-b15/server-jre-7u80-linux-x64.tar.gz -o 12.1.3/download/server-jre-7u80-linux-x64.tar.gz

usage() {
        echo "Usage: $0 [-f] [-o]
        -f        Force to download or overwrite existed. optional
        -o        Use original package name, default: java.tar.gz. optional
" >/dev/stderr
        exit 1
}

CONTEXT_DIR=$(dirname "${BASH_SOURCE}")
DOWNLOAD_DIR=$CONTEXT_DIR/download

# JAVA_URL=http://download.oracle.com/otn-pub/java/8u92-b14/server-jre-8u92-linux-x64.tar.gz
# JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/8u112-b15/server-jre-8u112-linux-x64.tar.gz
JAVA_URL=http://download.oracle.com/otn-pub/java/jdk/7u80-b15/server-jre-7u80-linux-x64.tar.gz

JAVA_TGT=java.tar.gz
FORCE_DL=false

while getopts "fo" opt; do
        case $opt in
                f)
                        FORCE_DL=true
                        ;;
                o)
                        JAVA_TGT=${JAVA_URL##*/}
                        ;;
                \?)
                        usage
                        ;;
        esac
done

[[ -d $DOWNLOAD_DIR ]] || mkdir -p $DOWNLOAD_DIR

if [[ true = $FORCE_DL || ! -f $DOWNLOAD_DIR/$JAVA_TGT ]]; then
  # Only worked on java 7/8
  curl -jkSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    -o $DOWNLOAD_DIR/$JAVA_TGT \
    $JAVA_URL
fi
