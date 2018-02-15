#!/bin/bash

function build_tool_set_env
{
	# stop the shell error
	NONE_TOOL_ENV=Foo
}

function build_tool_configure
{
	cd "$PKG_BUILD_DIR" || exit 1
}

function build_tool_build
{
	cd "$PKG_BUILD_DIR" || exit 1
}

function build_tool_install
{
	cd "$PKG_BUILD_DIR" || exit 1
}
