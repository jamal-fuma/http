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
AC_DEFUN([FUMA_AX_SET_WEBTOOLKIT_PATH],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_PATH start
#---------------------------------------------------------------
# default to wanting webtoolkit and searching for a path
fuma_ax_$2_path="";
fuma_ax_$2_required="yes";

# don't want $2
AS_IF([test "x${$1}" = "xno"], [fuma_ax_$2_required="no";],
[dnl
    # do want $2 and want to search for a path - this is the default
    AS_IF([test "x${$1}" = "xyes"], [fuma_ax_$2_required="yes";],
    [dnl
        # do want $2 and have an explicit path, which we only set if it's a existing directory
        AS_IF([test -d "${$1}"],[fuma_ax_$2_path="${$1}";],
        [dnl
            AC_MSG_ERROR(['${$1}' is not a valid directory path])dnl
        ])dnl
    ])dnl
])
#---------------------------------------------------------------
# FUMA_AX_SET_WEBTOOLKIT_PATH end
#---------------------------------------------------------------
        ])
