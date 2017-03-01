#!/bin/bash

function set_common_env ()
{
	ABUILD_SCRIPT_PATH=$( cd $(dirname $0) ; pwd -P )

	# use basename to get script name
	#ABUILD_SCRIPT_NAME=`
	ABUILD_PKG_DIRECTORY="$ABUILD_SCRIPT_PATH/packages/$ABUILD_PKG_NAME"
	ABUILD_PKG_FILE="$ABUILD_PKG_DIRECTORY/ABUILD"
}
