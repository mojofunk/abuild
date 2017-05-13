#!/bin/bash

function print_usage ()
{
	echo "usage: $ABUILD_SCRIPT_NAME [-t] <toolset> [-d] [-h] [-v] [-s] <command> <package>"
	echo " "
	echo "The toolsets are:"
	echo "    gcc"
	echo "    mingw"
	echo "    msvc"
	echo "    clang"
	echo " "
	echo "The commands are:"
	echo "    prep"
	echo "    configure"
	echo "    build"
	echo "    install"
	echo "    package"
	echo "    clean"
}

function parse_options ()
{
	OPTIND=1
	while getopts "h?t:dvsi:" opt; do
		case "$opt" in
		h)
			print_usage
			exit 0
			;;
		v)
			ABUILD_VERBOSE=1
			set -x
			;;
		t)
			TOOLSET=$OPTARG
			;;
		d)
			ABUILD_ENABLE_DEBUG=1
			;;
		i)
			PKG_INSTALL_DIR=$OPTARG
			;;
		s)
			ABUILD_SINGLE_COMMAND=1
			;;
		esac
	done
	shift "$((OPTIND-1))"

	if [ -z $1 ] || [ -z $2 ]; then
		print_usage
		echo "You must specify command and package name"
		exit 1
	fi

	ABUILD_PKG_COMMAND="$1"
	ABUILD_PKG_NAME="$2"
}
