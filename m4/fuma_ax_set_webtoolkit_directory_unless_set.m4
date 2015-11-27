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
AC_DEFUN([FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET start
#---------------------------------------------------------------

# if the $1 dir is explicitly set use that in preference to path discovery
    AS_IF([test "x$fuma_ax_webtoolkit_$1_dir_path" != "x"],[$1_dir="$fuma_ax_webtoolkit_$1_dir_path";],[$1_dir="$2";])
#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET end
#---------------------------------------------------------------
        ])
