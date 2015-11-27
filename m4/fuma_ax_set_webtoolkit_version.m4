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
AC_DEFUN([FUMA_AX_SET_WEBTOOLKIT_VERSION],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_VERSION start
#---------------------------------------------------------------
# extract most significant digit as major version
   fuma_ax_$2_version_major=`expr $1 : '\([[0-9]]*\)'`;

# extract next most significant digit as minor version
  fuma_ax_$2_version_minor=`expr $1 : '[[0-9]]*\.\([[0-9]]*\)'`;

# extract least significant digit as micro version
  fuma_ax_$2_version_micro=`expr $1 : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  AS_IF([test "x$fuma_ax_$2_version_micro" = "x"], [fuma_ax_$2_version_micro="0";])

# calculate a cannonical version number
  fuma_ax_$2_version_number=`expr $fuma_ax_$2_version_major \* 16777216 \+  $fuma_ax_$2_version_minor \* 65536 \+ $fuma_ax_$2_version_micro \* 256`;

  fuma_ax_$2_version_str="${fuma_ax_$2_version_major}.${fuma_ax_$2_version_minor}.${fuma_ax_$2_version_micro}";

#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_VERSION end
#---------------------------------------------------------------
        ])
