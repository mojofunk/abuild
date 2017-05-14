#!/bin/bash

function default_prep ()
{
	cd $PKG_BUILD_DIR || exit 1

	if [ ! -d $PKG_NAME ]; then

		# If PKG_REPO defined checkout repository
		if [ -n ${PKG_REPO} ]; then
			git clone $PKG_REPO || exit 1
		fi
		cd $PKG_NAME
		if [ -n ${PKG_BRANCH} ]; then
			git checkout $PKG_BRANCH || exit 1
		fi
	else
		cd $PKG_NAME
	fi
}

function prep ()
{
	echo "Package $ABUILD_PKG_NAME using default prep"
	default_prep
}

function configure ()
{
	echo "Package $ABUILD_PKG_NAME using default configure"
}

function build ()
{
	echo "Package $ABUILD_PKG_NAME using default build"
}

function install ()
{
	echo "Package $ABUILD_PKG_NAME using default install"
}

function package ()
{
	echo "Package $ABUILD_PKG_NAME using default package"
	echo "Creating tarball from $PKG_INSTALL_DIR ..."
	cd $PKG_INSTALL_DIR
	echo "pwd: "
	pwd
	# This won't pick up any hidden files, not sure we need to?
	tar -cvJf $PKG_INSTALL_DIR.tar.xz *
	cd -
}

function clean ()
{
	echo "Package $ABUILD_PKG_NAME using default clean"

	if [ -d "$PKG_BUILD_DIR" ]; then
		echo "Removing $PKG_BUILD_DIR"
		rm -rf "$PKG_BUILD_DIR" || exit 1
	fi

	if [ -d "$PKG_INSTALL_DIR" ]; then
		echo "Removing $PKG_INSTALL_DIR"
		rm -rf "$PKG_INSTALL_DIR" || exit 1
	fi
}

function process_command_sequence ()
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

function process_command_single ()
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

function process_command ()
{
	mkdir -p $PKG_BUILD_DIR || exit 1
	mkdir -p $PKG_INSTALL_DIR || exit 1

	if [ -n "$ABUILD_SINGLE_COMMAND" ]; then
		process_command_single
	else
		process_command_sequence
	fi
}
