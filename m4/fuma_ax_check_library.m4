dnl (c) FumaSoftware 2015
dnl
dnl Platform detection for autotools
dnl
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.  This file is offered as-is,
dnl without any warranty.
dnl
dnl platform detection
AC_DEFUN([FUMA_AX_CHECK_LIBRARY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBRARY start
#---------------------------------------------------------------
    AC_MSG_CHECKING(for ability to link against lib$1$fuma_ax_default_library_ext with LDFLAGS $2)

    $5_LDFLAGS="$2";
    $6_LIBS="$3";

    FUMA_AX_PUSH_CPPFLAGS([SAVED],[$4])
    FUMA_AX_PUSH_LDFLAGS([SAVED],[${$5_LDFLAGS}])
    FUMA_AX_PUSH_LIBS([SAVED],[${$6_LIBS}])

    AC_REQUIRE([AC_PROG_CXX])
    AC_LANG_PUSH(C++)
    AC_LINK_IFELSE([dnl
        AC_LANG_PROGRAM([$7], [$8])], [$9="yes"], [$9="no"])
    AC_LANG_POP([C++])

    FUMA_AX_POP_FLAGS([SAVED])
    AS_IF([test "x${$9}" = "xyes"], [dnl
            AC_SUBST([$5_LDFLAGS])
            AC_SUBST([$6_LIBS])
            AC_DEFINE([HAVE_$6],[1],[define if the $6 library is present])])

    AC_MSG_RESULT([${$9}])
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBRARY end
#---------------------------------------------------------------
        ])
