#!/bin/bash

function system_is_detected ()
{
	if [ -f /etc/system-release ]; then
		if [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "19" ]; then
			BUILD_SYSTEM='Fedora-19'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "20" ]; then
			BUILD_SYSTEM='Fedora-20'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "21" ]; then
			BUILD_SYSTEM='Fedora-21'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "24" ]; then
			BUILD_SYSTEM='Fedora-24'
		fi
			BUILD_SYSTEM_FEDORA=1
		return 0
	fi

	return 1
}

function system_toolset_supported ()
{
	if [ "$TOOLSET" == 'gcc' ]; then
		return 0
	elif [ "$TOOLSET" == 'clang' ]; then
		return 0
	elif [ "$TOOLSET" == 'mingw' ]; then
		return 0
	fi
	return 1
}

function system_set_default_host_arch ()
{
	${HOST_ARCH:=`uname -i`}
}

function system_set_default_toolset ()
{
	TOOLSET='gcc'
}

# TODO setup_build_system ()
# install required system packages etc
