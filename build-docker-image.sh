#!/bin/bash -e

# Wrapper around printf - clobber print since it's not POSIX anyway
print() { printf "%s\n" "$*"; }

# Exit fatally with a message to stderr
die() {
	print "
Build-Docker-Image error:

$1" 1>&2
	exit ${2:-1}
}

# remove temp files
clean_temp() {
	for f in "$BUILD_TEMP_FILE" "$BUILD_TEMP_FILE_2" "$BUILD_TEMP_FILE_3"
	do	[ -f "$f" ] && rm "$f" 2>/dev/null
	done
}

# Sets $1 as the value contained in $2 and exports (may be blank)
set_var() {
	local var=$1
	shift
	local value="$*"
	eval "export $var=\"\${$var-$value}\""
}

NL='
'

JAVA_PKG=server-jre-7u80-linux-x64


# Parse options
while :; do
	# Separate option from value:
	opt="${1%%=*}"
	val="${1#*=}"
	empty_ok= # Empty values are not allowed unless excepted

	case "$opt" in
	--java)
		empty_ok=1
		export EASYRSA_CERT_EXPIRE="$val"
		export EASYRSA_CA_EXPIRE="$val"
		export EASYRSA_CRL_DAYS="$val"
		;;
	--tomcat)
		empty_ok=1
		export EASYRSA_PKI="$val" ;;
	--batch)
		empty_ok=1
		export EASYRSA_BATCH=1 ;;
	*)
		break ;;
	esac

	# fatal error when no value was provided
	if [ ! $empty_ok ] && { [ "$val" = "$1" ] || [ -z "$val" ]; }; then
		die "Missing value to option: $opt"
	fi

	shift
done
		
# Register clean_temp on EXIT
trap "clean_temp" EXIT

