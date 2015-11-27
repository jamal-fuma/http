# Copyright 2012 Canonical Ltd.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 3, as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.

# Checks for existence of coverage tools:
# * gcov
# * lcov
# * genhtml
# * gcovr
#
# Sets ac_cv_check_gcov to yes if tooling is present
# and reports the executables to the variables LCOV, GCOVR and GENHTML.
#
AC_DEFUN([AC_TDD_GCOV_SET_PROGRAMS],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_SET_PROGRAMS start
#---------------------------------------------------------------
 AC_CHECK_PROG(GENHTML, genhtml, genhtml)
 AS_IF([test -z "$GENHTML"],
 [AC_MSG_ERROR([Could not find genhtml from the lcov package])])

 AC_CHECK_PROG(CPPFILT, c++filt, c++filt)
 AS_IF([test -z "$CPPFILT"],
 [AC_MSG_ERROR([Could not find c++filt from the lcov package])])

 AC_CHECK_PROGS(GCOV, [gcov-mp-4.8 gcov], gcov)
 AS_IF([test -z "$GCOV"],
 [AC_MSG_ERROR([Could not find gcov from the lcov package])])
#---------------------------------------------------------------
# AC_TDD_GCOV_SET_PROGRAMS end
#---------------------------------------------------------------
 ])

AC_DEFUN([AC_TDD_GCOV_CHECK_PROGRAMS],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_CHECK_PROGRAMS start
#---------------------------------------------------------------
 glib_cv_lcov_version="invalid"
 AC_CHECK_PROG(LCOV, lcov, lcov)
 AS_IF([test "$LCOV"],
     [lcov_version=`$LCOV -v 2>/dev/null | $SED -e 's/^.* //'`;
     m4_foreach([lcov_check_version], [[1.6],[1.7], [1.8],[1.9],[1.10]],
         [AS_IF([test "$lcov_version" = "lcov_check_version"],
             [glib_cv_lcov_version="lcov_check_version (ok)"])
         ])
     ])

 dnl is the version suitable
 AS_IF([test "${glib_cv_lcov_version}" = "invalid"],
 [AC_MSG_ERROR([To enable code coverage reporting you need a lcov version in the range (1.6 .. 1.10)])],
 [AC_TDD_GCOV_SET_PROGRAMS])
#---------------------------------------------------------------
# AC_TDD_GCOV_CHECK_PROGRAMS end
#---------------------------------------------------------------
 ])

AC_DEFUN([AC_TDD_GCOV_CHECK_CCACHE],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_CHECK_CCACHE start
#---------------------------------------------------------------
 AC_CHECK_PROG([SHTOOL], [shtool], [shtool])

 dnl are ccache tools present in the environment
 AS_IF([test "x$SHTOOL" = "x"],
 [gcc_ccache=no],
 [gcc_compiler_path=`$SHTOOL path $CC`])

 dnl is the gcc version in use being fronted by ccache
 AS_CASE([${gcc_compiler_path}],
 [*ccache*],
 [gcc_ccache=yes],
 [gcc_ccache=no])

 dnl is the ccache disabled in the environment
 AS_IF([test "x$gcc_ccache" = "xyes"],
 [AS_IF([test "x$CCACHE_DISABLE" = "x1"],
 [gcc_ccache=no])])

 dnl cannot proceed as ccache is not disabled within the environment
 AS_IF([test "x$gcc_ccache" = "xyes"],
 [AC_MSG_ERROR([ccache must be disabled when --enable-gcov option is used.
 You can disable ccache by setting environment variable CCACHE_DISABLE=1.])])
#---------------------------------------------------------------
# AC_TDD_GCOV_CHECK_CCACHE end
#---------------------------------------------------------------
 ])


AC_DEFUN([AC_TDD_GCOV_ENABLE_FEATURE],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_ENABLE_FEATURE start
#---------------------------------------------------------------
 AC_ARG_ENABLE(gcov,
 AS_HELP_STRING([--enable-gcov],
 [enable coverage testing with gcov]),
 [use_gcov=yes], [use_gcov=no])

 dnl cant proceed any further without GCC
 AS_IF([test "x$use_gcov" = "xyes"],
 [AS_IF([test "$GCC" != "yes"],
 [AC_MSG_ERROR([GCC is required for --enable-gcov])])])

 dnl enable specific portion of makefile
 AM_CONDITIONAL(HAVE_GCOV, [test "x$use_gcov" = "xyes"])
#---------------------------------------------------------------
# AC_TDD_GCOV_ENABLE_FEATURE end
#---------------------------------------------------------------
])

AC_DEFUN([AC_TDD_GCOV_STRIP_OPTIMIZATION_FLAGS],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_STRIP_OPTIMIZATION_FLAGS start
#---------------------------------------------------------------
# Remove all optimization flags from CFLAGS
changequote({,})
 CFLAGS=`echo "$CFLAGS" | $SED -e 's/-O[0-9]*//g'`
 CPPFLAGS=`echo "$CPPFLAGS" | $SED -e 's/-O[0-9]*//g'`
changequote([,])
#---------------------------------------------------------------
# AC_TDD_GCOV_STRIP_OPTIMIZATION_FLAGS end
#---------------------------------------------------------------
])

AC_DEFUN([AC_TDD_GCOV_SET_COVERAGE_FLAGS],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV_SET_COVERAGE_FLAGS start
#---------------------------------------------------------------

 # Add the special gcc flags
 ac_tdd_gcov_compile_flags="--coverage -fno-default-inline -fno-inline  -fno-elide-constructors -fno-inline-small-functions"

 COVERAGE_CFLAGS="${ac_tdd_gcov_compile_flags}"
 COVERAGE_CXXFLAGS="${ac_tdd_gcov_compile_flags}"
 COVERAGE_LDFLAGS="--coverage -lgcov"

 AC_SUBST(COVERAGE_CFLAGS)
 AC_SUBST(COVERAGE_CXXFLAGS)
 AC_SUBST(COVERAGE_LDFLAGS)
#---------------------------------------------------------------
# AC_TDD_GCOV_SET_COVERAGE_FLAGS end
#---------------------------------------------------------------
])

AC_DEFUN([AC_TDD_GCOV],[dnl
#---------------------------------------------------------------
# AC_TDD_GCOV start
#---------------------------------------------------------------
 AC_TDD_GCOV_ENABLE_FEATURE
 AS_IF([test "x$use_gcov" = "xyes"], [AC_TDD_GCOV_CHECK_CCACHE])
 AS_IF([test "x$use_gcov" = "xyes"], [AC_TDD_GCOV_CHECK_PROGRAMS])
 AS_IF([test "x$use_gcov" = "xyes"], [AC_TDD_GCOV_STRIP_OPTIMIZATION_FLAGS])
 AS_IF([test "x$use_gcov" = "xyes"], [AC_TDD_GCOV_SET_COVERAGE_FLAGS])
#---------------------------------------------------------------
# AC_TDD_GCOV end
#---------------------------------------------------------------
])
