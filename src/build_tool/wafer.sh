#!/bin/bash

. $ABUILD_SRC_PATH/build_tool/waf_private.sh
. $ABUILD_SRC_PATH/build_tool/wafer_private.sh

function build_tool_set_env
{
	waf_set_env
	#wafer_set_env
}

function build_tool_configure
{
	wafer_configure
}

function build_tool_build
{
	wafer_build
}

function build_tool_install
{
	wafer_install
}
