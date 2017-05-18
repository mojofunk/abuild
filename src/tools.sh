#!/bin/bash

function download
{
	test -f ${1} || curl -k -L -o ${1} $2
}

function download_source_and_unpack
{
	cd $PKG_SRC_ROOT_DIR
	download $PKG_SRC $PKG_URL || exit 1
	tar xf ${PKG_SRC}
	# must not exists
	mv ${PKG_SRC_DIR} "$PKG_BUILD_ROOT_DIR/$PKG_NAME"
}

function autotools_configure
{
	# if HOST_SYSTEM then HOST_SYSTEM_ARG="--host=${HOST_SYSTEM}"

	if [ -n "$HOST_SYSTEM" ]; then
		HOST_SYSTEM_ARG=--host=${HOST_SYSTEM}
	fi

	# if BUILD_SYSTEM then BUILD_SYSTEM_ARG="--build=${BUILD_SYSTEM}"

	# CFLAGS CPPFLAGS CXXFLAGS LDFLAGS ?

	if [ -n "$PREFIX" ]; then
		PREFIX_ARG=--prefix=${PREFIX}
	fi

	./configure $PREFIX_ARG $HOST_SYSTEM_ARG ${1}
}

function autotools_build
{
	make $SMP_MAKEFLAGS
}

function autotools_install
{
	make install
}
