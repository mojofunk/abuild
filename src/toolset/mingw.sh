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
	export AR=${AR:=$HOST_SYSTEM-ar}
	export RANLIB=${RANLIB:=$HOST_SYSTEM-ranlib}
	export CC=${CC:=$HOST_SYSTEM-gcc}
	export CPP=${CPP:=$HOST_SYSTEM-g++}
	export CXX=${CXX:=$HOST_SYSTEM-g++}
	export AS=${AS:=$HOST_SYSTEM-as}
	export LINK_CC=${LINK_CC:=$HOST_SYSTEM-gcc}
	export LINK_CXX=${LINK_CXX:=$HOST_SYSTEM-g++}
	export WINRC=${WINRC:=$HOST_SYSTEM-windres}
	export STRIP=${STRIP:=$HOST_SYSTEM-strip}
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
