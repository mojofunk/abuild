#!/bin/bash

function set_pkg_path_env
{
	ABUILD_PKG_DIRECTORY="$ABUILD_ROOT_PATH/packages/$ABUILD_PKG_NAME"
	ABUILD_PKG_FILE="$ABUILD_PKG_DIRECTORY/ABUILD"
}

function check_pkg_env
{
	if [ -z "${PKG_NAME}" ]; then
		echo "Package $ABUILD_PKG_NAME needs to set PKG_NAME"
		exit 1
	fi
	if [ -z "${PKG_VERSION}" ]; then
		echo "Package $ABUILD_PKG_NAME needs to set PKG_VERSION"
		exit 1
	fi
	if [ -z "${HOST_ARCH+x}" ]; then
		echo "Required variable HOST_ARCH not set....exiting"
		exit 1
	fi
}

function print_pkg_env
{
	echo "PKG_NAME : $PKG_NAME"
	echo "PKG_VERSION : $PKG_VERSION"
	echo "HOST_ARCH : $HOST_ARCH"
}

function check_pkg_file
{
	if [ ! -d $ABUILD_PKG_DIRECTORY ] && [ ! -f $ABUILD_PKG_FILE ]; then
		echo "No ABUILD file exists at $ABUILD_PKG_FILE"
		exit 1
	fi
}

function set_pkg_source_dir_env
{
	PKG_DEFAULT_SRC_ROOT_DIR="$ABUILD_ROOT_PATH/SOURCE"

	: ${PKG_SRC_ROOT_DIR:="$PKG_DEFAULT_SRC_ROOT_DIR"}

	echo "Using package source root directory $PKG_SRC_ROOT_DIR"
}

function set_pkg_build_dir_env
{
	if [ -n "$ABUILD_PKG_ENABLE_DEBUG" ]; then
		PKG_DEFAULT_BUILD_ROOT_DIR_NAME="${TOOLSET}-${HOST_ARCH}-dbg"
	else
		PKG_DEFAULT_BUILD_ROOT_DIR_NAME="${TOOLSET}-${HOST_ARCH}"
	fi

	PKG_DEFAULT_BUILD_ROOT_DIR="$ABUILD_ROOT_PATH/BUILD/$PKG_DEFAULT_BUILD_ROOT_DIR_NAME"

	: ${PKG_BUILD_ROOT_DIR:="$PKG_DEFAULT_BUILD_ROOT_DIR"}

	echo "Using package build root directory $PKG_BUILD_ROOT_DIR"
}

function set_pkg_install_dir_env
{
	if [ -n "$ABUILD_PKG_ENABLE_DEBUG" ]; then
		PKG_INSTALL_DIR_NAME="${PKG_NAME}-${PKG_VERSION}-${TOOLSET}-${HOST_ARCH}-dbg"
	else
		PKG_INSTALL_DIR_NAME="${PKG_NAME}-${PKG_VERSION}-${TOOLSET}-${HOST_ARCH}"
	fi

	: ${PKG_INSTALL_ROOT_DIR:="$ABUILD_ROOT_PATH/INSTALL"}

	PKG_DEFAULT_INSTALL_DIR="$PKG_INSTALL_ROOT_DIR/$PKG_INSTALL_DIR_NAME"

	: ${PKG_INSTALL_DIR:="$PKG_DEFAULT_INSTALL_DIR"}

	echo "Using package install directory $PKG_INSTALL_DIR"

	PKG_BIN_DIR=$PKG_INSTALL_DIR/bin
	PKG_LIB_DIR=$PKG_INSTALL_DIR/lib
	PKG_ETC_DIR=$PKG_INSTALL_DIR/etc
	PKG_SHARE_DIR=$PKG_INSTALL_DIR/share

	# not sure if this is the best place for this but it can only be set
	# after the install path has been determined
	export PKG_CONFIG_PATH=${PKG_INSTALL_DIR}/lib/pkgconfig
}

function process_pkg_deps
{
	# TODO put in toplevel? or in /share
	ABUILD_PKG_CACHE_DIR="$PKG_INSTALL_DIR/abuild"

	for pkg in $PKG_DEPS
	do
		if [ ! -e "$ABUILD_PKG_CACHE_DIR/$pkg" ]; then
			echo "Building and Installing package dependency $pkg"

			$ABUILD_SCRIPT_PATH -t $TOOLSET $ABUILD_VERBOSE_OPTION \
			                    $PKG_VERBOSE_OPTION $PKG_DEBUG_OPTION \
			                    -i $PKG_INSTALL_DIR install \
			                    $pkg || exit 1

			mkdir -p "$ABUILD_PKG_CACHE_DIR"
			touch "$ABUILD_PKG_CACHE_DIR/$pkg"
		else
			echo "Package dependency $pkg already installed"
		fi
	done
}
