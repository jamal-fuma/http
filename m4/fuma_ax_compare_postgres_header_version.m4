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
AC_DEFUN([FUMA_AX_COMPARE_POSTGRES_HEADER_VERSION],[dnl
#---------------------------------------------------------------
# FUMA_AX_COMPARE_POSTGRES_HEADER_VERSION start
#---------------------------------------------------------------
    AC_MSG_CHECKING(for <libpq-fe.h> defining a version number >= ${$1} under ${$3})

    # export a include path for our test
    POSTGRES_CPPFLAGS="-I${include_dir}";
    FUMA_AX_PUSH_CPPFLAGS([SAVED],[$POSTGRES_CPPFLAGS])

    AC_REQUIRE([AC_PROG_CXX])
    AC_LANG_PUSH(C++)
    AC_COMPILE_IFELSE([dnl
            AC_LANG_PROGRAM([[@%:@include <libpq-fe.h>]],
                    [[PGresult *result;]])dnl
            ],
            [$2="yes"],
            [$2="no"])
    AC_LANG_POP([C++])

    FUMA_AX_POP_FLAGS([SAVED])
    AS_IF([test "x${$1}" = "xyes"], [dnl
            AC_SUBST([POSTGRES_CPPFLAGS])
            AC_DEFINE([HAVE_LIBPQ_FE_H],[1],[define if the PostgreSQL libpq-fe.h header is available])
            ])

    AC_MSG_RESULT([${$2}])
#---------------------------------------------------------------
# FUMA_AX_COMPARE_POSTGRES_HEADER_VERSION end
#---------------------------------------------------------------
        ])
