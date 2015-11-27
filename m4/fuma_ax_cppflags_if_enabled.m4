dnl (c) FumaSoftware 2012
dnl
dnl Conditionally append to CPPFLAGS
dnl
dnl Copying and distribution of this file, with or without modification,
dnl are permitted in any medium without royalty provided the copyright
dnl notice and this notice are preserved.  This file is offered as-is,
dnl without any warranty.
dnl
dnl
AC_DEFUN([FUMA_AX_CPPFLAGS_IF_ENABLED],[
#---------------------------------------------------------------
# FUMA_AX_CPPFLAGS_IF_ENABLED start
#---------------------------------------------------------------

        # conditionally append to CPPFLAGS
        AS_IF([test "x${$1}" = "xtrue"], [CPPFLAGS="$CPPFLAGS $2"])

#---------------------------------------------------------------
# FUMA_AX_CPPFLAGS_IF_ENABLED end
#---------------------------------------------------------------
        ])

dnl conditionally append to CPPFLAGS
AC_DEFUN([FUMA_AX_CPPFLAGS_IF_DISABLED],[
#---------------------------------------------------------------
# FUMA_AX_CPPFLAGS_IF_DISABLED start
#---------------------------------------------------------------

        # conditionally append to CPPFLAGS
        AS_IF([test "x${$1}" = "xfalse"], [CPPFLAGS="$CPPFLAGS $2"])

#---------------------------------------------------------------
# FUMA_AX_CPPFLAGS_IF_DISABLED end
#---------------------------------------------------------------
        ])


dnl conditionally append to CFLAGS
AC_DEFUN([FUMA_AX_CFLAGS_IF_ENABLED],[
#---------------------------------------------------------------
# FUMA_AX_CFLAGS_IF_ENABLED start
#---------------------------------------------------------------

        # conditionally append to CFLAGS
        AS_IF([test "x${$1}" = "xtrue"], [CFLAGS="$CFLAGS $2"])

#---------------------------------------------------------------
# FUMA_AX_CFLAGS_IF_ENABLED end
#---------------------------------------------------------------
        ])

dnl conditionally append to CFLAGS
AC_DEFUN([FUMA_AX_CFLAGS_IF_DISABLED],[
#---------------------------------------------------------------
# FUMA_AX_CFLAGS_IF_DISABLED start
#---------------------------------------------------------------

        # conditionally append to CFLAGS
        AS_IF([test "x${$1}" = "xfalse"], [CFLAGS="$CFLAGS $2"])

#---------------------------------------------------------------
# FUMA_AX_CFLAGS_IF_DISABLED end
#---------------------------------------------------------------
        ])
