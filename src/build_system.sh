#!/bin/bash

function set_build_system_env ()
{
	if [ -f /etc/system-release ]; then
		if [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "19" ]; then
			BUILD_SYSTEM='Fedora-19'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "20" ]; then
			BUILD_SYSTEM='Fedora-20'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "21" ]; then
			BUILD_SYSTEM='Fedora-21'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "24" ]; then
			BUILD_SYSTEM='Fedora-24'
		fi
			BUILD_SYSTEM_FEDORA=1
	elif [ -f /etc/debian_version ]; then
		BUILD_SYSTEM='debian'
		BUILD_SYSTEM_DEBIAN=1
	elif [ -n "${MSYSTEM}" ]; then
		BUILD_SYSTEM='MSYS2'
		# TODO this should go somewhere else, this is host env
		if [ "${MSYSTEM}" == 'MINGW64' ]; then
			HOST_ARCH="x86_64"
		fi
		BUILD_SYSTEM_MSYS2=1
	else
		echo "Cannot determine build system....exiting"
		exit 1
	fi
	echo "Build system ${BUILD_SYSTEM} detected"
}

# Setup build environment based on the build system
function set_build_env ()
{

	if [ -n "$BUILD_SYSTEM_FEDORA" ]; then
		. ./src/build_system_fedora.sh
	elif [ -n "$BUILD_SYSTEM_MSYS2" ]; then
		. ./src/build_system_msys2.sh
	elif [ -n "$BUILD_SYSTEM_DEBIAN" ]; then
		. ./src/build_system_debian.sh
	else
		echo "Using native toolset"
	fi
	
	set_toolset_env
}
