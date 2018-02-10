#!/bin/bash

function wafer_set_env
{
	TOOLSET_ARG="--toolset=${TOOLSET}"
}

function wafer_configure
{
	#waf_set_env
	#wafer_set_env
	./wafer ${PKG_VERBOSE_OPTION} configure $TOOLSET_ARG $PREFIX_ARG $LIBDIR_ARG ${1}
}

function wafer_build
{
	./wafer ${PKG_VERBOSE_OPTION} build $SMP_MAKEFLAGS ${1}
}

function wafer_install
{
	./wafer ${PKG_VERBOSE_OPTION} install ${1}
}