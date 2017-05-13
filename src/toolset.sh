#!/bin/bash

function set_toolset ()
{
	if [ -z ${TOOLSET+x} ]; then
		system_set_default_toolset
	else
		if ! system_toolset_supported; then
			echo "${TOOLSET} not supported on ${BUILD_SYSTEM}....exiting"
			exit 1
		fi
	fi

	TOOLSET_FILE="${ABUILD_SRC_PATH}/toolset/${TOOLSET}.sh"
	if [ -f ${TOOLSET_FILE} ];then
		. ${TOOLSET_FILE}
		toolset_set_env
	else
		echo "No configuration file found for ${TOOLSET}"
	fi

	echo "Using Toolset ${TOOLSET}"
}
