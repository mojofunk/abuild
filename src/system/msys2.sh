#!/bin/bash

function _set_msys2_mingw_env ()
{
	export PYTHON=/usr/bin/python3

	# TODO /mingw64
	export MINGW_ROOT=/mingw32

	export PKG_CONFIG_LIBDIR=$MINGW_ROOT/lib/pkgconfig
	export PKGCONFIG=/usr/bin/pkg-config
	export WINRC=windres
	export AR=$HOST_SYSTEM-gcc-ar
}

function system_is_detected ()
{
	if [ -n "${MSYSTEM}" ]; then
		BUILD_SYSTEM='MSYS2'
		BUILD_SYSTEM_MSYS2=1
		return 0
	fi
	return 1
}

function system_set_default_host_arch ()
{
	if [ "${MSYSTEM}" == 'MINGW64' ]; then
		HOST_ARCH="x86_64"
	else
		HOST_ARCH="i686"
	fi
}

function system_toolset_supported ()
{
	if [ "$TOOLSET" == 'mingw' ]; then
		return 0
	elif [ "$TOOLSET" == 'msvc' ]; then
		return 0
	fi
	return 1
}

function system_set_build_env ()
{
	if [ "$TOOLSET" == 'mingw' ]; then
		_set_msys2_mingw_env
	fi
}

function system_set_default_toolset ()
{
	TOOLSET='mingw'
}
