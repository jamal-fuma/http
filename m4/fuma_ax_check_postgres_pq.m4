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
AC_DEFUN([FUMA_AX_CHECK_POSTGRES_PQ_LIBRARY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_POSTGRES_PQ_LIBRARY start
#---------------------------------------------------------------
FUMA_AX_CHECK_LIBRARY([pq],
                [-L${$2} -Wl,-rpath,${$2}],
                [-lpq],
                [${POSTGRES_CPPFLAGS}],
                [POSTGRES],
                [POSTGRES_PQ],
                [[@%:@include <libpq-fe.h>]],
                [[int input = PQlibVersion();]],
                [$1])
#---------------------------------------------------------------
# FUMA_AX_CHECK_POSTGRES_PQ_LIBRARY end
#---------------------------------------------------------------
        ])

