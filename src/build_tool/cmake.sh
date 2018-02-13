#!/bin/bash

. "${BUILD_TOOL_DIR}"/make_private.sh

function cmake_set_env
{
	if [ "$TOOLSET" == "mingw" ]; then
		CMAKE_SYSTEM_NAME_ARG=-DCMAKE_SYSTEM_NAME=Windows
		CMAKE_RC_COMPILER_ARG=-DCMAKE_RC_COMPILER="$(which $WINRC)"
	fi

	if [ "$PKG_DEBUG_ENABLE" ]; then
		CMAKE_BUILD_TYPE_ARG=-DCMAKE_BUILD_TYPE=Debug
	else
		CMAKE_BUILD_TYPE_ARG=-DCMAKE_BUILD_TYPE=Release
	fi

	CMAKE_INSTALL_PREFIX_ARG="-DCMAKE_INSTALL_PREFIX=${PREFIX}"

	CMAKE_BUILD_SHARED_LIBS_ARG=-DBUILD_SHARED_LIBS=ON

	CMAKE_BUILD_DIR="cmakebuild"

	make_set_env
}

function cmake_configure
{
	cd "$PKG_BUILD_DIR" || exit 1

	rm -rf $CMAKE_BUILD_DIR
	mkdir $CMAKE_BUILD_DIR && cd $CMAKE_BUILD_DIR || exit 1

	cmake $CMAKE_VERBOSE_ARG $CMAKE_BUILD_SHARED_LIBS_ARG $CMAKE_INSTALL_PREFIX \
	$CMAKE_BUILD_TYPE_ARG $CMAKE_RC_COMPILER_ARG $CMAKE_SYSTEM_NAME_ARG ${1} \
	..

	cd -
}

function cmake_build
{
	cd "$PKG_BUILD_DIR" || exit 1
	cd $CMAKE_BUILD_DIR && make $MAKE_VERBOSE_ARG $SMP_MAKEFLAGS
	cd -
}

function cmake_install
{
	cd "$PKG_BUILD_DIR" || exit 1
	cd $CMAKE_BUILD_DIR && make $MAKE_VERBOSE_ARG install
	cd -
}

function build_tool_set_env
{
	cmake_set_env
}

function build_tool_configure
{
	cmake_configure
}

function build_tool_build
{
	cmake_build
}

function build_tool_install
{
	cmake_install
}
