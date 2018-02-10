#!/bin/bash

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

function build_tool_set_env
{
	autotools_set_env
}

function build_tool_configure
{
	autotools_configure
}

function build_tool_build
{
	autotools_build
}

function build_tool_install
{
	autotools_install
}
