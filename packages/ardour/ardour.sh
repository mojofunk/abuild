#!/bin/bash

ARDOUR_PKG_DEPS="\
gcc-libs \
gtkmm24 \
libsndfile \
boost \
curl \
libarchive \
liblo \
taglib \
vamp-plugin-sdk \
rubberband \
aubio \
portaudio \
lv2 \
suil \
sratom \
serd \
lilv \
libusb \
mingw-libgnurx"

function ardour_define_version_env
{
	# Always determined via git checkout atm

	GIT_DESCRIBE=`git describe HEAD`

	GIT_REV_REGEXP='([0-9][0-9]*)\.([0-9][0-9]*)\-?([pr][rc]e?[0-9]*)?-?([0-9][0-9]*)?(-g([a-f0-9]+))?'
	#GIT_REV_REGEXP='([0-9][0-9]*)\.([0-9][0-9]*)\-?(rc[0-9]*)?-?([0-9][0-9]*)?(-g([a-f0-9]+))?'

	MAJOR_VERSION=`echo "$GIT_DESCRIBE" | sed -r -e "s/$GIT_REV_REGEXP/\1/"`
	MINOR_VERSION=`echo "$GIT_DESCRIBE" | sed -r -e "s/$GIT_REV_REGEXP/\2/"`
	RC=`echo "$GIT_DESCRIBE" | sed -r -e "s/$GIT_REV_REGEXP/\3/"`
	REVISION=`echo "$GIT_DESCRIBE" | sed -r -e "s/$GIT_REV_REGEXP/\4/"`
	COMMIT=`echo "$GIT_DESCRIBE" | sed -r -e "s/$GIT_REV_REGEXP/\6/"`

	if [ "x$RC" != "x" ] ; then
		REVCOUNT=$RC${REVISION:+.$REVISION}
	elif [ "x$REVISION" != "x" ] ; then
		REVCOUNT=$REVISION
	else
		REVCOUNT=0
	fi

	VERSION=${MAJOR_VERSION}.${MINOR_VERSION}${REVCOUNT:+.$REVCOUNT}
}

function ardour_set_env
{
	ardour_define_version_env

	: ${ARDOUR_PROGRAM_NAME:="Ardour"}
	: ${ARDOUR_PRODUCT_NAME:="ardour"}

	# this seems wrong
	: ${ARDOUR_PRODUCT_ID:="${ARDOUR_PROGRAM_NAME}${MAJOR_VERSION}"}

	# this seems wrong
	: ${ARDOUR_PRODUCT_EXE:="${ARDOUR_PRODUCT_NAME}-${VERSION}.exe"}
	: ${ARDOUR_PRODUCT_ICON:="${ARDOUR_PRODUCT_NAME}.ico"}

	# hardcoded?
	ARDOUR_FILE_EXTENSION=ardour

	ARDOUR_DATA_DIRNAME="${ARDOUR_PRODUCT_NAME}${MAJOR_VERSION}"
	ARDOUR_DATA_DIR="$PKG_SHARE_DIR/${ARDOUR_DATA_DIRNAME}"

	if [ "$TOOLSET" == "mingw" ]; then
		DIST_TARGET_ARG="--dist-target=mingw"
		VST_ARG="--windows-vst"
	fi

	if [ "$PKG_ENABLE_DEBUG" ]; then
		ARDOUR_BUILD_ARG="--debug --backtrace --debug-symbols"
		#ARDOUR_TEST_ARG="--test --single-tests"
	else
		ARDOUR_BUILD_ARG="--optimize"
	fi

	: ${ARDOUR_PROGRAM_NAME_ARG:="--program-name=${ARDOUR_PROGRAM_NAME}"}

	: ${ARDOUR_COMMON_ARG:="$VST_ARG $DIST_TARGET_ARG $ARDOUR_PROGRAM_NAME_ARG --cxx11"}

	: ${ARDOUR_PATH_ARG:="--prefix=/ --configdir=/share"}

	if [ "$TOOLSET" == "mingw" ]; then
		if [ "$PKG_ENABLE_DEBUG" ]; then
			: ${ARDOUR_BACKEND_ARG:="--with-backends=portaudio,dummy"}
		else
			: ${ARDOUR_BACKEND_ARG:="--with-backends=portaudio"}
		fi
	else
		if [ "$PKG_ENABLE_DEBUG" ]; then
			: ${ARDOUR_BACKEND_ARG:="--with-backends=alsa,jack,dummy"}
		else
			: ${ARDOUR_BACKEND_ARG:="--with-backends=alsa,jack"}
		fi
	fi
}

function ardour_post_install
{
	echo "Moving Ardour dll's and executable to $PKG_BIN_DIR ..."

	mv "$PKG_LIB_DIR/$ARDOUR_DATA_DIRNAME"/*.dll "$PKG_BIN_DIR"
	mv "$PKG_LIB_DIR/$ARDOUR_DATA_DIRNAME"/*.exe $PKG_BIN_DIR

	echo "Overwriting icon files ..."

	cp "$PKG_BUILD_DIR/gtk2_ardour/icons/cursor_square/"* "$ARDOUR_DATA_DIR/icons/"

	echo "Deleting import libs ..."

	#rm "$PKG_LIB_DIR"/*dll.a

	# delete exec helper script

	EXEC_SCRIPT="$PKG_LIB_DIR/$ARDOUR_PRODUCT_NAME$MAJOR_VERSION"

	if [ -f $EXEC_SCRIPT ]; then
		rm $EXEC_SCRIPT || exit 1
	fi
}
