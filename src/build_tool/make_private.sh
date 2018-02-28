function make_set_env
{
	if [ "$PKG_VERBOSE_OPTION" ]; then
		MAKE_VERBOSE_ARG="VERBOSE=1"
	fi

	: ${MAKEFLAGS:="-j4"}
}
