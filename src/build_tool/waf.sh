#!/bin/bash

. "$BUILD_TOOL_DIR"/waf_private.sh

function build_tool_set_env
{
	waf_set_env
}

function build_tool_configure
{
	waf_configure
}

function build_tool_build
{
	waf_build
}

function build_tool_install
{
	waf_install
}
