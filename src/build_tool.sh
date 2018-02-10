#!/bin/bash

function set_build_tool
{
	if [ -z ${PKG_BUILD_TOOL+x} ]; then
		echo "PKG_BUILD_TOOL variable not set by ${PKG_NAME}"
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
