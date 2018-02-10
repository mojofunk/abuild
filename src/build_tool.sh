#!/bin/bash

function set_build_tool
{
	if [ -z ${PKG_BUILD_TOOL+x} ]; then
		echo "PKG_BUILD_TOOL variable not set by ${PKG_NAME}"
		return
	fi

	BUILD_TOOL_FILE="${ABUILD_SRC_PATH}/build_tool/${PKG_BUILD_TOOL}.sh"
	if [ -f ${BUILD_TOOL_FILE} ]; then
		. ${BUILD_TOOL_FILE}
		build_tool_set_env
	else
		echo "No configuration file found for ${PKG_BUILD_TOOL}"
	fi

	echo "Using build tool ${PKG_BUILD_TOOL}"
}

function autotools_set_env
{
	if [ -n "$HOST_SYSTEM" ]; then
		HOST_SYSTEM_ARG=--host=${HOST_SYSTEM}
	fi

	# if BUILD_SYSTEM then BUILD_SYSTEM_ARG="--build=${BUILD_SYSTEM}"

	# CFLAGS CPPFLAGS CXXFLAGS LDFLAGS ?

	if [ -n "$PREFIX" ]; then
		PREFIX_ARG=--prefix=${PREFIX}
	fi

	if [ -n "$PKG_VERBOSE_ENABLE" ]; then
		CONFIGURE_VERBOSE_ARG="--verbose"
		MAKE_VERBOSE_ARG="V=1"
	fi
}

function autotools_configure
{
	./configure $CONFIGURE_VERBOSE_ARG $PREFIX_ARG $HOST_SYSTEM_ARG ${1}
}

function autotools_build
{
	make $MAKE_VERBOSE_ARG $SMP_MAKEFLAGS
}

function autotools_install
{
	make $MAKE_VERBOSE_ARG install
}
