#!/bin/bash

function set_common_env
{
	ABUILD_ROOT_PATH=$( cd $(dirname $0) ; pwd -P )
	ABUILD_ROOT_PATH_BUILD="$ABUILD_ROOT_PATH/BUILD"
	ABUILD_ROOT_PATH_INSTALL="$ABUILD_ROOT_PATH/INSTALL"
	ABUILD_ROOT_PATH_SOURCE="$ABUILD_ROOT_PATH/SOURCE"
	ABUILD_SRC_PATH="$ABUILD_ROOT_PATH/src"

	ABUILD_SCRIPT_NAME=`basename $0`
	ABUILD_SCRIPT_PATH="$ABUILD_ROOT_PATH/$ABUILD_SCRIPT_NAME"
}
