#!/bin/bash

function wafer_set_env
{
	#waf_set_env ?
	TOOLSET_ARG="--toolset=${TOOLSET}"
}

function wafer_configure
{
	$PYTHON wafer ${PKG_VERBOSE_OPTION} configure $TOOLSET_ARG $PREFIX_ARG $LIBDIR_ARG ${1}
}

function wafer_build
{
	$PYTHON wafer ${PKG_VERBOSE_OPTION} build $MAKEFLAGS ${1}
}

function wafer_install
{
	$PYTHON wafer ${PKG_VERBOSE_OPTION} install ${1}
}
