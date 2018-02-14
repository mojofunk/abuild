#!/bin/bash

# return true if default_prep has already been run, which we
# assume has happened if $PKG_BUILD_DIR exists
function default_prep
{
	cd $PKG_BUILD_ROOT_DIR || exit 1

	if [ ! -d $PKG_NAME ]; then
		if [ -n "$PKG_REPO" ]; then
			git clone "$PKG_REPO" || exit 1
			cd "$PKG_NAME"
			if [ -n "${PKG_BRANCH}" ]; then
				git checkout $PKG_BRANCH || exit 1
			fi
		elif [ -n "${PKG_SRC_URL}" ]; then
			download_source_and_unpack
		fi
		cd "$PKG_BUILD_DIR" || exit 1
		return 0
	else
		cd "$PKG_BUILD_DIR" || exit 1
		return 1
	fi
}

function prep
{
	echo "Package $ABUILD_PKG_NAME using default prep"
	default_prep || return 0
}

function default_configure
{
	cd "$PKG_BUILD_DIR" || exit 1
	build_tool_configure
}

function configure
{
	echo "Package $ABUILD_PKG_NAME using default configure"
	default_configure
}

function default_build
{
	cd "$PKG_BUILD_DIR" || exit 1
	build_tool_build
}

function build
{
	echo "Package $ABUILD_PKG_NAME using default build"
	default_build
}

function default_install
{
	cd "$PKG_BUILD_DIR" || exit 1
	build_tool_install
}

function install
{
	echo "Package $ABUILD_PKG_NAME using default install"
	default_install
}

function default_package
{
	echo "Creating tarball from $PKG_INSTALL_DIR ..."
	cd $PKG_INSTALL_DIR
	echo "pwd: "
	pwd
	# This won't pick up any hidden files, not sure we need to?
	tar -cvJf $PKG_INSTALL_DIR.tar.xz *
	cd -
}

function package
{
	echo "Package $ABUILD_PKG_NAME using default package"
	default_package
}

function default_clean
{
	if [ -d "$PKG_BUILD_ROOT_DIR" ]; then
		echo "Removing $PKG_BUILD_ROOT_DIR"
		rm -rf "$PKG_BUILD_ROOT_DIR" || exit 1
	fi

	if [ -d "$PKG_INSTALL_DIR" ]; then
		echo "Removing $PKG_INSTALL_DIR"
		rm -rf "$PKG_INSTALL_DIR" || exit 1
	fi
}

function clean
{
	echo "Package $ABUILD_PKG_NAME using default clean"
	default_clean
}

function process_command_sequence
{
	case $ABUILD_PKG_COMMAND in
	prep)
		prep || exit 1
		;;
	configure)
		prep || exit 1
		configure || exit 1
		;;
	build)
		prep || exit 1
		configure || exit 1
		build || exit 1
		;;
	install)
		prep || exit 1
		configure || exit 1
		build || exit 1
		install || exit 1
		;;
	package)
		prep || exit 1
		configure || exit 1
		build || exit 1
		install || exit 1
		package || exit 1
		;;
	clean)
		clean || exit 1
		;;
	*)
		print_usage
		exit 1
		;;
	esac
}

function process_command_single
{
	case $ABUILD_PKG_COMMAND in
	prep)
		prep || exit 1
		;;
	configure)
		configure || exit 1
		;;
	build)
		build || exit 1
		;;
	install)
		install || exit 1
		;;
	package)
		package || exit 1
		;;
	clean)
		clean || exit 1
		;;
	*)
		print_usage
		exit 1
		;;
	esac
}

function process_command
{
	mkdir -p $PKG_SRC_ROOT_DIR || exit 1
	mkdir -p $PKG_BUILD_ROOT_DIR || exit 1
	mkdir -p $PKG_INSTALL_DIR || exit 1

	if [ -n "$ABUILD_SINGLE_COMMAND" ]; then
		process_command_single
	else
		process_command_sequence
	fi
}
