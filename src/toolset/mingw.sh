#!/bin/bash

function set_mingw_default_build_env ()
{
	: ${HOST_ARCH:="i686"}
	: ${HOST_SYSTEM:="${HOST_ARCH}-w64-mingw32"}
	: ${MINGW_ROOT:="/usr/$HOST_SYSTEM/sys-root/mingw"}
}

function set_mingw_default_toolset_env ()
{
	export PKG_CONFIG_PREFIX=${PKG_CONFIG_PREFIX:=$MINGW_ROOT}
	export PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR:=$MINGW_ROOT/lib/pkgconfig}
	export PKGCONFIG=${PKGCONFIG:=pkg-config}
	export PYTHON=${PYTHON:=python}
}

# a package could override this if necessary
function mingw_copydll ()
{
	if [ -f $MINGW_ROOT/bin/$1 ]; then
		cp $MINGW_ROOT/bin/$1 $2 || return 1
		return 0
	fi

	echo "ERROR: File $1 does not exist"
	return 1
}

function toolset_set_env ()
{
	set_mingw_default_build_env
	set_mingw_default_toolset_env
}
