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
AC_DEFUN([FUMA_AX_CHECK_WEBTOOLKIT_TEST_LIBRARY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_WEBTOOLKIT_TEST_LIBRARY start
#---------------------------------------------------------------
FUMA_AX_CHECK_LIBRARY([wttest],
                [-L${$2} -Wl,-rpath,${$2} ${BOOST_LDFLAGS}],
                [-lwttest -lwt ${BOOST_SYSTEM_LIB} ${PTHREAD_LIBS}],
                [${WEBTOOLKIT_CPPFLAGS} ${BOOST_CPPFLAGS}],
                [WEBTOOLKIT],
                [WEBTOOLKIT_TEST],
                [[@%:@include <Wt/Test/WTestEnvironment>]],
                [[Wt::Test::WTestEnvironment environment]],
                [$1])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WEBTOOLKIT_TEST_LIBRARY end
#---------------------------------------------------------------
        ])
