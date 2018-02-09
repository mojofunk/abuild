#!/bin/bash

function print_usage
{
	echo "usage: $ABUILD_SCRIPT_NAME [-t] <toolset> [-d] [-f] [-l] [-h] [-V] [-v] [-s] <command> <package>"
	echo " "
	echo "[-t] Toolset: gcc, mingw, msvc, clang"
	echo "[-d] Build a debug version of the package (and dependencies)"
	echo "[-f] Force install package (and dependencies) even if already installed"
	echo "[-l] List available packages"
	echo "[-h] List this help"
	echo "[-V] Enable verbose $ABUILD_SCRIPT_NAME output"
	echo "[-v] Enable verbose package build output"
	echo "[-s] Execute a single build command"
	echo "<command> : prep, configure, build, install, package, clean"
}

function print_packages
{
	ls -1 packages
}

function check_host_arch
{
	if [ "$HOST_ARCH" == "i686" ]; then
		:
	elif [ "$HOST_ARCH" == "x86_64" ]; then
		:
	else
		echo "Unsupported HOST_ARCH specified : $HOST_ARCH"
		exit 1
	fi
	echo "HOST_ARCH set to : $HOST_ARCH"
}

function parse_options
{
	OPTIND=1
	while getopts "a:h?t:dflvVsi:" opt; do
		case "$opt" in
		a)
			HOST_ARCH=$OPTARG
			check_host_arch
			;;
		h)
			print_usage
			exit 0
			;;
		V)
			ABUILD_VERBOSE_OPTION=-V
			set -x
			;;
		v)
			PKG_VERBOSE_ENABLE=true
			PKG_VERBOSE_OPTION=-v
			;;
		t)
			TOOLSET=$OPTARG
			;;
		d)
			PKG_DEBUG_ENABLE=true
			PKG_DEBUG_OPTION=-d
			;;
		f)
			ABUILD_FORCE_INSTALL=true
			;;
		l)
			# TODO
			print_packages
			exit 0
			;;
		i)
			PKG_INSTALL_DIR=$OPTARG
			;;
		s)
			ABUILD_SINGLE_COMMAND=1
			;;
		?)
			exit 1
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
