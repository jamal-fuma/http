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
AC_DEFUN([FUMA_AX_DEBUG],[dnl
#---------------------------------------------------------------
# FUMA_AX_DEBUG start
#---------------------------------------------------------------

# Add the --enable-debug arg
        AC_ARG_ENABLE([debug],AS_HELP_STRING([--enable-debug],[Turn on debugging]),[debug=true],[debug=false])

        dnl there must be a better way to
        AS_IF([test "x${debug}" = "xtrue"],  [CFLAGS=`echo $CFLAGS | sed -e 's/-O2/-O0/'`])
        AS_IF([test "x${debug}" = "xtrue"],  [CXXFLAGS=`echo $CXXFLAGS | sed -e 's/-O2/-O0/'`])
        AS_IF([test "x${debug}" = "xtrue"],  [AM_CFLAGS=`echo $AM_CFLAGS | sed -e 's/-O2/-O0/'`])
        AS_IF([test "x${debug}" = "xtrue"],  [AM_CXXFLAGS=`echo $AM_CXXFLAGS | sed -e 's/-O2/-O0/'`])
        AS_IF([test "x${debug}" = "xfalse"], [CFLAGS=`echo $CFLAGS | sed -e 's/-g/-DNDEBUG -g -D_FORTIFY_SOURCE=2 -fstack-protector-all -Wstack-protector/'`])

        AM_CONDITIONAL([DEBUG], [test "x$debug" = "xtrue"])
#---------------------------------------------------------------
# FUMA_AX_DEBUG end
#---------------------------------------------------------------
        ])
