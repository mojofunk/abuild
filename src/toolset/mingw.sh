#!/bin/bash

function set_mingw_default_build_env
{
	# These two are more like system properties than toolset
	: ${HOST_SYSTEM:="${HOST_ARCH}-w64-mingw32"}
	: ${MINGW_ROOT:="/usr/$HOST_SYSTEM/sys-root/mingw"}

	if [ -z "${CFLAGS}" ]; then
		if [ -n "$PKG_DEBUG_ENABLE" ]; then
			GLOBAL_CFLAGS="-O0 -g"
		else
			GLOBAL_CFLAGS="-O2"
		fi
	fi

	export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
	export CFLAGS="-I${PREFIX}/include ${GLOBAL_CFLAGS} -mstackrealign ${CFLAGS}"
	export CXXFLAGS="-I${PREFIX}/include ${GLOBAL_CFLAGS} -mstackrealign ${CXXFLAGS}"
	export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"
}

function set_mingw_default_toolset_env
{
	export PYTHON=${PYTHON:=python}
}

# a package could override this if necessary
function mingw_copydll
{
	if [ -f $MINGW_ROOT/bin/$1 ]; then
		cp $MINGW_ROOT/bin/$1 $2 || return 1
		return 0
	fi

	echo "ERROR: File $1 does not exist"
	return 1
}

function toolset_set_env
{
	set_mingw_default_build_env
	set_mingw_default_toolset_env
}
