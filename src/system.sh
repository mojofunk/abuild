#!/bin/bash

function set_system ()
{
	for system_file in "$ABUILD_ROOT_PATH/src/system"/*
	do
		if [ -f "$system_file" ];then
			. "$system_file"
			if system_is_detected; then
				system_set_env
				break
			fi
		fi
	done

}

function check_system_env ()
{
	if [ -z ${BUILD_SYSTEM+x} ]; then
		echo "Cannot determine build system....exiting"
		exit 1
	fi
}

function print_system_env ()
{
	echo "BUILD_SYSTEM : ${BUILD_SYSTEM}"
}

# The system API/Interface

# Setup required environment variables
function system_set_env ()
{
	echo "Using default system Environment"
}

# The system may need to do further setup after the toolset has been
# set, this is the function to do it in.
function system_set_build_env ()
{
	echo "Using default system build environment"
}

function system_set_default_toolset ()
{
	echo "Setting a default toolset is required"
	exit 1
}
