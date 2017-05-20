#!/bin/bash

function set_build_tool
{
	if [ -z ${PKG_BUILD_TOOL+x} ]; then
		echo "${PKG_BUILD_TOOL} not set by ${PKG_NAME}"
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
}

function autotools_configure
{
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

function waf_set_env
{
	PREFIX_ARG="--prefix=${PREFIX}"

	if [ ${TOOLSET} == 'mingw' ]; then
		C_COMPILER_NAME=gcc
		CXX_COMPILER_NAME=g++
	elif [ ${TOOLSET} == 'clang' ]; then
		C_COMPILER_NAME=clang
		CXX_COMPILER_NAME=clang++
	elif [ ${TOOLSET} == 'msvc' ]; then
		C_COMPILER_NAME=msvc
	elif [ ${TOOLSET} == 'gcc' ]; then
		C_COMPILER_NAME=gcc
		CXX_COMPILER_NAME=g++
	fi

	if [ -n "$C_COMPILER_NAME" ]; then
		C_COMPILER_ARG="--check-c-compiler=${C_COMPILER_NAME}"
	fi

	if [ -n "$CXX_COMPILER_NAME" ]; then
		CXX_COMPILER_ARG="--check-cxx-compiler=${CXX_COMPILER_NAME}"
	fi

	if [ -n "$LIBDIR" ]; then
		LIBDIR_ARG="--libdir=${LIBDIR}"
	fi
}

function wafer_configure
{
	waf_set_env
	./wafer ${PKG_VERBOSE_OPTION} configure $PREFIX_ARG $LIBDIR_ARG \
	                                        $C_COMPILER_ARG $CXX_COMPILER_ARG ${1}
}

function wafer_build
{
	./wafer ${PKG_VERBOSE_OPTION} build $SMP_MAKEFLAGS ${1}
}

function wafer_install
{
	./wafer ${PKG_VERBOSE_OPTION} install ${1}
}
