#!/bin/bash

. ./src/system.sh
. ./src/toolset.sh
. ./src/commands.sh
. ./src/options.sh
. ./src/package.sh
. ./src/common_env.sh
#. ./src/tools.sh

parse_options $@

set_common_env

check_pkg_file

set_system

check_system_env

print_system_env

# export environment based on build system and host/compiler
set_toolset

system_set_build_env

# source the package file to get variables and functions
. $ABUILD_PKG_FILE

# call function defined by package to setup environment
set_pkg_env

# Check that the package has set at least the required environment vars 
check_pkg_env

print_pkg_env

# Set the directories used by the package for build/installation
set_pkg_build_dir_env
set_pkg_install_dir_env

process_pkg_deps

process_command
