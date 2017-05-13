#!/bin/bash

SCRIPT_NAME=`basename $0`

function print_usage ()
{
	echo "usage: $SCRIPT_NAME [-t] <toolset> [-d] [-h] <command> <package>"
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
			echo "Enabling verbose output"
			set -x
			;;
		t)
			TOOLSET=$OPTARG
			echo "Enabling toolset $TOOLSET"
			;;
		d)
			ABUILD_ENABLE_DEBUG=1
			;;
		i)
			PKG_INSTALL_DIR=$OPTARG
			;;
		s)
			# can this just be ABUILD_INSTALL_DIR??
			ABUILD_SINGLE_COMMAND=1
			echo "Executing single command"
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
