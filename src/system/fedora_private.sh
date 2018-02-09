#!/bin/bash

function _set_fedora_mingw_env
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
