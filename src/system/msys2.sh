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
		# TODO this should go somewhere else, this is host env
		if [ "${MSYSTEM}" == 'MINGW64' ]; then
			HOST_ARCH="x86_64"
		fi
		BUILD_SYSTEM_MSYS2=1
		return 0
	fi
	return 1
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
	elif [ "$TOOLSET" == 'msvc' ]; then
	fi
}

function system_set_default_toolset ()
{
	$TOOLSET='gcc'
}
