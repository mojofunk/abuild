#!/bin/bash

function check_pkg_env ()
{
	if [ -z "${PKG_NAME}" ]; then
		echo "Package $ABUILD_PKG_NAME needs to set PKG_NAME"
		exit 1
	fi
	if [ -z "${PKG_VERSION}" ]; then
		echo "Package $ABUILD_PKG_NAME needs to set PKG_VERSION"
		exit 1
	fi
}

function check_pkg_file ()
{
	#echo "Checking Package $2"

	if [ ! -d $ABUILD_PKG_DIRECTORY ] && [ ! -f $ABUILD_PKG_FILE ]; then
		echo "No ABUILDPKG file exists at $ABUILD_PKG_FILE"
		exit 1
	fi
}

function set_pkg_dir_env ()
{
	# TODO add compiler to dir name

	ABUILD_PKG_BUILD_DIR="$ABUILD_PKG_SCRIPT_PATH/BUILD"
	mkdir -p $ABUILD_PKG_BUILD_DIR

	# install directly into ABUILD_PKG_INSTALL_DIR dir if defined
	if [ -z $ABUILD_PKG_INSTALL_DIR ]; then
		ABUILD_PKG_INSTALL_DIR="$ABUILD_PKG_SCRIPT_PATH/INSTALL"
		echo "Installing packages to $ABUILD_PKG_INSTALL_DIR as ABUILD_PKG_INSTALL_DIR is not defined"
	fi

	# Figure out the Build Type
	if [ -n "$ABUILD_PKG_ENABLE_DEBUG" ]; then
		PKG_INSTALL_DIR_NAME="${PKG_NAME}-${PKG_VERSION}-${ARCH}-dbg"
	else
		PKG_INSTALL_DIR_NAME="${PKG_NAME}-${PKG_VERSION}-${ARCH}"
	fi
	PKG_INSTALL_DIR="$ABUILD_PKG_INSTALL_DIR/$PKG_INSTALL_DIR_NAME"

	if [ -n "${ABUILD_PKG_OVERRIDE_INSTALL_DIR}" ]; then
		PKG_INSTALL_DIR="$ABUILD_PKG_OVERRIDE_INSTALL_DIR"
		echo "Using install dir $PKG_INSTALL_DIR"
	fi

	PKG_BIN_DIR=$PKG_INSTALL_DIR/bin
	PKG_LIB_DIR=$PKG_INSTALL_DIR/lib
	PKG_ETC_DIR=$PKG_INSTALL_DIR/etc
	PKG_SHARE_DIR=$PKG_INSTALL_DIR/share
}

function process_pkg_deps ()
{
	if [ -n "${ABUILD_PKG_VERBOSE}" ]; then
		VERBOSE_FLAGS=-v
	fi

	if [ -n "${ABUILD_PKG_ENABLE_DEBUG}" ]; then
		DEBUG_FLAGS=-d
	fi

	# TODO put in toplevel? or in /share
	ABUILD_PKG_CACHE_DIR="$PKG_INSTALL_DIR/abuild"

	for pkg in $PKG_DEPS
	do
		if [ ! -e "$ABUILD_PKG_CACHE_DIR/$pkg" ]; then
			echo "Building package dependency $pkg"

			# TODO call the same script/executable if separate scripts for
			# each build type are used.

			$ABUILD_PKG_SCRIPT_PATH/abuild.sh $VERBOSE_FLAGS $DEBUG_FLAGS \
					-i $PKG_INSTALL_DIR $ABUILD_PKG_COMMAND $pkg || exit 1

			if [ $ABUILD_PKG_COMMAND == 'install' ]; then
				mkdir -p "$ABUILD_PKG_CACHE_DIR"
				touch "$ABUILD_PKG_CACHE_DIR/$pkg"
			fi
		else
			echo "Package dependency $pkg already installed"
		fi
	done
}
