#!/bin/bash

. ./src/system.sh
. ./src/toolset.sh
. ./src/build_tool.sh
. ./src/commands.sh
. ./src/options.sh
. ./src/package.sh
. ./src/common_env.sh
. ./src/utils.sh

set_common_env

parse_options $@

set_pkg_path_env

check_pkg_file

set_system

system_set_default_host_arch

check_system_env

print_system_env

system_install_required_tools

# export environment based on build system and host/compiler
set_toolset

system_set_toolset_env

# source the package file to get variables and functions
. $ABUILD_PKG_FILE

# call function defined by package to setup environment
set_pkg_env

# Check that the package has set at least the required environment vars 
check_pkg_env

print_pkg_env

# Set the directories used by the package for build/installation
set_pkg_source_dir_env
set_pkg_build_dir_env
set_pkg_install_dir_env

system_set_path_env

set_build_tool

process_pkg_deps

process_command
