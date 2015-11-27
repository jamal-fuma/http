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
AC_DEFUN([FUMA_AX_SET_AX_ASTYLE_VERSION],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE_VERSION start
#---------------------------------------------------------------
# extract most significant digit as major version
   fuma_ax_$2_version_string="$1";
   fuma_ax_$2_version_major=`expr ${fuma_ax_$2_version_string} : '\([[0-9]]*\)'`;
# extract next most significant digit as minor version
fuma_ax_$2_version_minor=`expr ${fuma_ax_$2_version_string} : '[[0-9]]*\.\([[0-9]]*\)'`;

# extract least significant digit as micro version
  fuma_ax_$2_version_micro=`expr ${fuma_ax_$2_version_string} : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`;
  AS_IF([test "x$fuma_ax_$2_version_micro" = "x"], [fuma_ax_$2_version_micro="0";])

# calculate a cannonical version number
  fuma_ax_$2_version_number=`expr $fuma_ax_$2_version_major \* 10000 \+  $fuma_ax_$2_version_minor \* 1000 \+ $fuma_ax_$2_version_micro \* 100`;
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE_VERSION end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_ASTYLE_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE_FLAGS start
#---------------------------------------------------------------

    # Allman style closing brackets will be broken from the preceding line.
    ASTYLE_FLAGS="--style=allman"

    # Indent 'case X:' blocks from the 'case X:' headers.
    # Case statements not enclosed in blocks are NOT indented.
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --indent-cases"

    # Add extra indentation to namespace blocks.
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --indent-namespaces"

    # Indent multi-line preprocessor definitions ending with a backslash,
    #  converting tabs to spaces in the non-indentation part of the line.
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --indent-preprocessor --convert-tabs"

    # Remove  extra  space  padding around parenthesis on the inside and outside.
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --unpad-paren"

    # Attach a pointer or reference operator to the middle
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --align-pointer=middle"

    # Indent 'class' and 'struct' blocks so access modifiers are indented
    ASTYLE_FLAGS="${ASTYLE_FLAGS} --indent-classes"

    ASTYLE="${$1} ${ASTYLE_FLAGS}"
    AC_SUBST([ASTYLE])
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE_FLAGS end
#---------------------------------------------------------------
])

AC_DEFUN([FUMA_AX_ASTYLE],[dnl
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE start
#---------------------------------------------------------------
    dnl try and find the binary
    FUMA_AX_SET_AX_ASTYLE_VERSION([$1],[astyle_desired])
    AC_MSG_CHECKING(["for astyle version >= ${fuma_ax_astyle_desired_version_number}"])
    AC_CHECK_PROG([ASTYLE_TOOL], [astyle], [astyle])

    dnl work out the version number
    AS_IF([test "x${ASTYLE_TOOL}" = "x"],
        [AC_MSG_RESULT(["astyle was not found in the search path"])],
        [AC_MSG_RESULT(["astyle found in path as ${ASTYLE_TOOL}"])])

    AS_IF([test "x${ASTYLE_TOOL}" = "x"],[],[
        astyle_version_number=`${ASTYLE_TOOL} --version 2>&1 | ${AWK} '{ print $NF; }'`
        FUMA_AX_SET_AX_ASTYLE_VERSION([$astyle_version_number], [astyle_actual])])

    dnl compare version numbers
    AS_IF([test "x${ASTYLE_TOOL}" = "x"],[],[
        AS_IF([test ${fuma_ax_astyle_actual_version_number} -ge ${fuma_ax_astyle_desired_version_number}],
            [fuma_ax_astyle_ok=yes]) ])

    dnl export variables for use within makefile
    AS_IF([test "x${fuma_ax_astyle_ok}" = "xyes"],
        [FUMA_AX_ASTYLE_FLAGS([ASTYLE_TOOL])])

    dnl export a suitable makefile variable with the various options setup
    AM_CONDITIONAL([HAVE_ASTYLE],
            [test "x${fuma_ax_astyle_ok}" = "xyes"])

    AS_IF([test "x${fuma_ax_astyle_ok}" = "xyes"],
        [AC_MSG_RESULT(["found suitable version ${fuma_ax_astyle_actual_version_number}"])],
        [AC_MSG_RESULT(["found obsolete version ${fuma_ax_astyle_actual_version_number} but it was too old"])])
#---------------------------------------------------------------
# FUMA_AX_SET_AX_ASTYLE end
#---------------------------------------------------------------
])
