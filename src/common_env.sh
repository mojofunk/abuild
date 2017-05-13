#!/bin/bash

function set_common_env ()
{
	ABUILD_ROOT_PATH=$( cd $(dirname $0) ; pwd -P )

	ABUILD_SCRIPT_NAME=`basename $0`
	ABUILD_SCRIPT_PATH="$ABUILD_ROOT_PATH/$ABUILD_SCRIPT_NAME"

	ABUILD_PKG_DIRECTORY="$ABUILD_ROOT_PATH/packages/$ABUILD_PKG_NAME"
	ABUILD_PKG_FILE="$ABUILD_PKG_DIRECTORY/ABUILD"
}
