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

function waf_setup_env
{
	PREFIX_ARG=--prefix=${PREFIX}

	if [ ${TOOLSET} == 'mingw' ]; then
		C_COMPILER_NAME=gcc
		CXX_COMPILER_NAME=g++
	elif [ ${TOOLSET} == 'clang']; then
		C_COMPILER_NAME=clang
		CXX_COMPILER_NAME=clang++
	elif [ ${TOOLSET} == 'msvc']; then
		C_COMPILER_NAME=msvc
		CXX_COMPILER_NAME=mvsc
	elif [ ${TOOLSET} == 'gcc']; then
		C_COMPILER_NAME=gcc
		CXX_COMPILER_NAME=g++
	fi

	if [ -n "$C_COMPILER_NAME" ]; then
		C_COMPILER_ARG=--check-c-compiler=${C_COMPILER_NAME}
	fi

	if [ -n "$CXX_COMPILER_NAME" ]; then
		CXX_COMPILER_ARG=--check-cxx-compiler=${CXX_COMPILER_NAME}
	fi
}

function waf_configure
{

}

function wafer_configure
{
	waf_setup_env
	./wafer ${PKG_VERBOSE_OPTION} configure $PREFIX_ARG $C_COMPILER_ARG $CXX_COMPILER_ARG
}

function wafer_build
{
	./wafer ${PKG_VERBOSE_OPTION} build $SMP_MAKEFLAGS
}

function wafer_install
{
	./wafer ${PKG_VERBOSE_OPTION} install --destdir="$PKG_INSTALL_DIR"
}
