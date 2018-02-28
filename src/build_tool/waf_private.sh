#!/bin/bash

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

	export PYTHON=${PYTHON:=python3}
}

function waf_configure
{
	$PYTHON waf ${PKG_VERBOSE_OPTION} configure $PREFIX_ARG $LIBDIR_ARG ${1}
}

function waf_build
{
	$PYTHON waf ${PKG_VERBOSE_OPTION} build $MAKEFLAGS ${1}
}

function waf_install
{
	$PYTHON waf ${PKG_VERBOSE_OPTION} install ${1}
}
