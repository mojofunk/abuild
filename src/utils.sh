#!/bin/bash

function download
{
	test -f ${1} || curl -k -L -o ${1} $2
}

function download_source_and_unpack
{
	cd $PKG_SRC_ROOT_DIR
	echo "Downloading $PKG_SRC_URL ..."
	download $PKG_SRC_FILE $PKG_SRC_URL || exit 1
	tar xf ${PKG_SRC_FILE}
	# must not exist
	mv ${PKG_SRC_DIR} "$PKG_BUILD_ROOT_DIR/$PKG_NAME"
}
