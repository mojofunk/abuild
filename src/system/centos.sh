#!/bin/bash

. $ABUILD_SRC_PATH/system/fedora_private.sh

function system_is_detected
{
	if [ -f /etc/centos-release ]; then
		BUILD_SYSTEM='Centos'
		BUILD_SYSTEM_CENTOS=1
		return 0
	fi

	return 1
}

function system_install_build_tools
{
	echo "Installing $BUILD_SYSTEM build tools"

	DNF=yum

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
