#!/bin/bash

# TODO setup_build_system ()
# install required system packages etc

function set_toolset_env ()
{
	if [ -z "$TOOLSET" ]; then
		echo "Using native/unmodified Fedora toolset"
	else
		if [ "$TOOLSET" == 'mingw' ]; then
			# TODO setup mingw build env
			. ./src/mingw_env.sh
			set_mingw_default_toolset_env
		elif [ "$TOOLSET" == 'clang' ]; then
			. ./src/clang_env.sh
		else
			echo "Toolset $TOOLSET unsupported on Fedora"
			exit 1
		fi
	fi
}
