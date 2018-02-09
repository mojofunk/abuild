#!/bin/bash

. $ABUILD_SRC_PATH/system/fedora_private.sh

function system_is_detected
{
	if [ -f /etc/fedora-release ]; then
		if [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "19" ]; then
			BUILD_SYSTEM='Fedora-19'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "20" ]; then
			BUILD_SYSTEM='Fedora-20'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "21" ]; then
			BUILD_SYSTEM='Fedora-21'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "24" ]; then
			BUILD_SYSTEM='Fedora-24'
		fi
			BUILD_SYSTEM='Fedora'
			BUILD_SYSTEM_FEDORA=1
		return 0
	fi

	return 1
}

function system_install_build_tools
{
	echo "Installing $BUILD_SYSTEM build tools"

	DNF=dnf

	sudo $DNF group install -y "Development Tools"

	COMMON_DEPS="git gitk"

	sudo $DNF install -y $COMMON_DEPS

	MINGW_DEPS="mingw*gcc mingw*gcc-c++"

	sudo $DNF install -y $MINGW_DEPS
}

function system_toolset_supported
{
	if [ "$TOOLSET" == 'gcc' ]; then
		return 0
	elif [ "$TOOLSET" == 'clang' ]; then
		return 0
	elif [ "$TOOLSET" == 'mingw' ]; then
		return 0
	fi
	return 1
}

function system_set_default_host_arch
{
	: ${HOST_ARCH:=i686}
}

function system_set_default_toolset
{
	TOOLSET='gcc'
}

function system_set_toolset_env
{
	if [ "$TOOLSET" == 'mingw' ]; then
		_set_fedora_mingw_env
	fi
}
