#!/bin/bash

. $ABUILD_SRC_PATH/system/fedora_private.sh

function system_is_detected
{
	if [ -f /etc/centos-release ]; then
		BUILD_SYSTEM='Centos'
		BUILD_SYSTEM_CENTOS=1
		return 0
	fi

	return 1
}

function system_install_build_tools
{
	DNF=yum
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
