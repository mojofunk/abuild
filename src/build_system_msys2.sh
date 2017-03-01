#!/bin/bash

function set_msys2_mingw_env ()
{
	export PYTHON=/usr/bin/python3

	# TODO /mingw64
	export MINGW_ROOT=/mingw32 

	export PKG_CONFIG_LIBDIR=$MINGW_ROOT/lib/pkgconfig
	export PKGCONFIG=/usr/bin/pkg-config
	export WINRC=windres
	export AR=$HOST_SYSTEM-gcc-ar
}

function set_toolset_env ()
{
	if [ -z "$TOOLSET" ]; then
		TOOLSET='mingw'
		echo "Using $TOOLSET Toolset"
	else
		if [ "$TOOLSET" == 'mingw' ]; then
			# TODO setup mingw build env
			. ./src/mingw_env.sh
			set_mingw_default_host_env
			set_mingw_default_toolset_env
			set_msys2_mingw_env
		elif [ "$TOOLSET" == 'msvc' ]; then
			echo "Using $TOOLSET Toolset"
		else
			echo "Toolset $TOOLSET unsupported on MSYS2"
			exit 1
		fi
	fi
}
