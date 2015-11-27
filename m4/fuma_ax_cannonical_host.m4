dnl (c) FumaSoftware 2012
dnl
dnl Platform detection for autotools
dnl
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.  This file is offered as-is,
dnl without any warranty.
dnl
dnl platform detection
AC_DEFUN_ONCE([FUMA_AX_CANONICAL_HOST],[
#---------------------------------------------------------------
# FUMA_AX_CANONICAL_HOST start
#---------------------------------------------------------------

        dnl set the host triplet
        AC_CANONICAL_HOST

        dnl set our platform flag
        case "${host}" in
            *-*-freebsd*)               freebsd=true;   unix=true; fuma_ax_build_platform="UNIX (FreeBSD)"    ;;
            *-*-darwin*)                darwin=true;    unix=true; fuma_ax_build_platform="UNIX (OSX)"    ;;
            *-*-linux*)                 linux=true;     unix=true; fuma_ax_build_platform="UNIX (LINUX)"  ;;
            *-*-mingw32*)               windows=true ; fuma_ax_build_platform="Windows (MINGW_W32)"  ;;
            *-*-mingw64*)               windows=true ; fuma_ax_build_platform="Windows (MINGW_W64)"  ;;
            *-*-win32*)                 windows=true ; fuma_ax_build_platform="Windows (MS_W32)"  ;;
            *-*-win64*)                 windows=true ; fuma_ax_build_platform="Windows (MS_W64)"  ;;
            *)                          unknown_build=true      ;;
        esac

        dnl grab date of build
        fuma_ax_build_date="Built on : `date | cut -c 1-24`"

        dnl produce a unique version string for this build
        fuma_ax_build_version="Version (${PACKAGE_VERSION}) ${fuma_ax_build_date}"

        dnl make sure the name of the app is used in the build version
        fuma_ax_build_label="${PACKAGE_NAME} ${fuma_ax_build_platform} ${fuma_ax_build_version}"

        export FUMA_BUILD_LABEL="$fuma_ax_build_label"
        AC_SUBST(FUMA_BUILD_LABEL)

        # enable the POSIX specific portions of the makefile
        AM_CONDITIONAL([UNIX], [test "x$unix" = "xtrue"])

        # enable the FreeBSD specific portions of the makefile
        AM_CONDITIONAL([FREEBSD], [test "x$freebsd" = "xtrue"])

        # enable the LINUX specific portions of the makefile
        AM_CONDITIONAL([LINUX], [test "x$linux" = "xtrue"])

        # enable the OSX specific portions of the makefile
        AM_CONDITIONAL([DARWIN], [test "x$darwin" = "xtrue"])

        # enable the Windows specific portions of the makefile
        AM_CONDITIONAL([WINDOWS],[test "x$windows" = "xtrue"])

	FUMA_AX_CPPFLAGS_IF_ENABLED([freebsd],[-DFREEBSD=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([unix],[-DUNIX=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([linux],[-DLINUX=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([darwin],[-DDARWIN=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([windows],[-DWINDOWS=1])

	# work out what is the default extension for the platform
        AS_IF([test "x$darwin" = "xtrue"],
	[
		fuma_ax_default_library_ext=".dylib"
	],
	[
		AS_IF([test "x$unix" = "xtrue"],
		[
			fuma_ax_default_library_ext=".so"
		],
		[
			fuma_ax_default_library_ext=".dll"
		])
	])
	export fuma_ax_default_library_ext="$fuma_ax_default_library_ext"

#---------------------------------------------------------------
# FUMA_AX_CANONICAL_HOST end
#---------------------------------------------------------------
        ])
