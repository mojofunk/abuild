#!/bin/bash

function _set_fedora_mingw_env ()
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

	export PKG_CONFIG_PREFIX=${PKG_CONFIG_PREFIX:=$MINGW_ROOT}
	export PKG_CONFIG_LIBDIR=${PKG_CONFIG_LIBDIR:=$MINGW_ROOT/lib/pkgconfig}
	#export PKGCONFIG=${PKGCONFIG:=pkg-config}

	# TODO this is only correct when using default PKG_INSTALL_DIR
	export PREFIX=${PREFIX:='/'}
}

function system_is_detected ()
{
	if [ -f /etc/system-release ]; then
		if [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "19" ]; then
			BUILD_SYSTEM='Fedora-19'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "20" ]; then
			BUILD_SYSTEM='Fedora-20'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "21" ]; then
			BUILD_SYSTEM='Fedora-21'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "24" ]; then
			BUILD_SYSTEM='Fedora-24'
		fi
			BUILD_SYSTEM_FEDORA=1
		return 0
	fi

	return 1
}

function system_toolset_supported ()
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

function system_set_default_host_arch {
	UNAME_ARCH=`uname -i`
	: ${HOST_ARCH:="$UNAME_ARCH"}
}

function system_set_default_toolset {
	TOOLSET='gcc'
}

function system_set_toolset_env {
	if [ "$TOOLSET" == 'mingw' ]; then
		_set_fedora_mingw_env
	fi
}
