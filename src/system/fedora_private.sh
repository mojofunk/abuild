#!/bin/bash

function _fedora_set_mingw_env
{
	export AR=${AR:=$HOST_SYSTEM-ar}
	export RANLIB=${RANLIB:=$HOST_SYSTEM-ranlib}
	export CC=${CC:=$HOST_SYSTEM-gcc}
	export CPP=${CPP:=$HOST_SYSTEM-cpp}
	export CXX=${CXX:=$HOST_SYSTEM-g++}
	export AS=${AS:=$HOST_SYSTEM-as}
	export LINK_CC=${LINK_CC:=$HOST_SYSTEM-gcc}
	export LINK_CXX=${LINK_CXX:=$HOST_SYSTEM-g++}
	export WINRC=${WINRC:=$HOST_SYSTEM-windres}
	export STRIP=${STRIP:=$HOST_SYSTEM-strip}

	# we don't really want to use system mingw packages
	#export PKG_CONFIG_PREFIX=${PKG_CONFIG_PREFIX:=$MINGW_ROOT}
	#export PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR:=$MINGW_ROOT/lib/pkgconfig}
}

function _fedora_system_install_build_tools
{
	echo "Installing $BUILD_SYSTEM build tools"

	sudo $DNF group install -y "Development Tools"

	COMMON_DEPS="git gitk"

	sudo $DNF install -y $COMMON_DEPS

	MINGW_DEPS="mingw*gcc mingw*gcc-c++"

	sudo $DNF install -y $MINGW_DEPS
}

function _fedora_system_toolset_supported
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

function _fedora_system_set_default_host_arch
{
	: ${HOST_ARCH:=i686}
}

function _fedora_system_set_default_toolset
{
	TOOLSET='gcc'
}

function _fedora_system_set_toolset_env
{
	if [ "$TOOLSET" == 'mingw' ]; then
		_fedora_set_mingw_env
	fi
}
