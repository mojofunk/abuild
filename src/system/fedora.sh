#!/bin/bash

. $ABUILD_SRC_PATH/system/fedora_private.sh

function system_is_detected
{
	if [ -f /etc/fedora-release ]; then
		if [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "19" ]; then
			BUILD_SYSTEM='Fedora-19'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "20" ]; then
			BUILD_SYSTEM='Fedora-20'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "21" ]; then
			BUILD_SYSTEM='Fedora-21'
		elif [ $(grep -ow -E [[:digit:]]+ /etc/system-release) == "24" ]; then
			BUILD_SYSTEM='Fedora-24'
		fi
			BUILD_SYSTEM='Fedora'
			BUILD_SYSTEM_FEDORA=1
		return 0
	fi

	return 1
}

function system_install_build_tools
{
	DNF=dnf
	_fedora_system_install_build_tools
}

function system_toolset_supported
{
	if _fedora_system_toolset_supported; then
		return 0
	fi
	return 1
}

function system_set_default_host_arch
{
	_fedora_system_set_default_host_arch
}

function system_set_default_toolset
{
	_fedora_system_set_default_toolset
}

function system_set_toolset_env
{
	_fedora_system_set_toolset_env
}
