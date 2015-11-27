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
# SYNOPSIS
#   FUMA_AX_WEBTOOLKIT([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the Webtoolkit C++ libraries of a particular version (or newer)
#
#   This macro calls:
#
#     AC_SUBST(WEBTOOLKIT_CPPFLAGS) / AC_SUBST(WEBTOOLKIT_LDFLAGS)
#     AC_SUBST([WEBTOOLKIT_DBO_MYSQL_LIBS])
#     AC_SUBST([WEBTOOLKIT_DBO_POSTGRES_LIBS])
#     AC_SUBST([WEBTOOLKIT_DBO_SQLITE3_LIBS])
#     AC_SUBST([WEBTOOLKIT_HTTP_LIBS])
#     AC_SUBST([WEBTOOLKIT_TEST_LIBS])
#
#   And sets:
#
#     HAVE_WEBTOOLKIT
#     HAVE_WEBTOOLKIT_DBO_MYSQL
#     HAVE_WEBTOOLKIT_DBO_POSTGRES
#     HAVE_WEBTOOLKIT_DBO_SQLITE3
#     HAVE_WEBTOOLKIT_HTTP
#     HAVE_WEBTOOLKIT_TEST
#
# LICENSE
# (c) FumaSoftware 2015

AC_DEFUN_ONCE([FUMA_AX_WEBTOOLKIT],[dnl
#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT start
#---------------------------------------------------------------
    #set defaults for our shell variables
        fuma_ax_webtoolkit_default_version="3.2.3"
    fuma_ax_webtoolkit_default_library_ext="${fuma_ax_default_library_ext}"
    fuma_ax_webtoolkit_user_version="$1"
    fuma_ax_webtoolkit_found="no"
    fuma_ax_webtoolkit_required="yes"
    fuma_ax_with_webtoolkit_library_dir="yes"
    fuma_ax_with_webtoolkit_include_dir="yes"
    fuma_ax_dbo_backend="sqlite3"

    # compare supplied version against the empty string,
    # if the caller supplied a version we use that otherwise we use fuma_ax_webtoolkit_default_version
    FUMA_AX_SET_WEBTOOLKIT_VERSION([ifelse([${fuma_ax_webtoolkit_user_version}],[],
            ["${fuma_ax_webtoolkit_default_version}"],
            ["${fuma_ax_webtoolkit_user_version}"])], [desired_webtoolkit])

    # Check whether --with-webtoolkit was given.
    AC_ARG_WITH([webtoolkit],
            [AS_HELP_STRING([--with-webtoolkit@<:@=ARG@:>@], [use Wt library from a standard location (ARG=yes),
                from the specified location (ARG=<path>), or disable it (ARG=no) @<:@ARG=yes@:>@ ])],
            [fuma_ax_with_webtoolkit=${withval}],
            [fuma_ax_with_webtoolkit="yes";])

    # export path of WebToolkit top level directory
    FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit],[webtoolkit])

    # allow overriding paths for location of WebToolkit
    AS_IF([test -d "${fuma_ax_webtoolkit_path}"], [dnl
        fuma_ax_webtoolkit_include_dir_path="${fuma_ax_webtoolkit_path}/include"
        fuma_ax_webtoolkit_library_dir_path="${fuma_ax_webtoolkit_path}/lib"])

    # Check whether --with-webtoolkit-include-dir was given.
    AC_ARG_WITH([webtoolkit-include-dir], [dnl
            AS_HELP_STRING([--with-webtoolkit-include-dir=@<:@ARG@:>@],[override include path for WebToolkit (ARG=path)])],
            [fuma_ax_with_webtoolkit_include_dir=${withval}],
            [fuma_ax_with_webtoolkit_include_dir="${fuma_ax_webtoolkit_required}"])

    # export include path for WebToolkit
    FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit_include_dir],[webtoolkit_include_dir])

    # allow overriding include paths for location of WebToolkit
    AS_IF([test -d "${fuma_ax_webtoolkit_include_dir_path}"], [dnl
            include_dir="${fuma_ax_webtoolkit_include_dir_path}"])

    # Check whether --with-webtoolkit-library-dir was given.
    AC_ARG_WITH([webtoolkit-library-dir], [dnl
            AS_HELP_STRING([--with-webtoolkit-library-dir=@<:@ARG@:>@],[override library path for PostgreSQL (ARG=path)])],
            [fuma_ax_with_webtoolkit_library_dir=${withval}],
            [fuma_ax_with_webtoolkit_library_dir="${fuma_ax_webtoolkit_required}"])

    # export library path for WebToolkit
    FUMA_AX_SET_WEBTOOLKIT_PATH([fuma_ax_with_webtoolkit_library_dir],[webtoolkit_library_dir])

    # allow overriding library paths for location of WebToolkit
    AS_IF([test -d "${fuma_ax_webtoolkit_library_dir_path}"], [dnl
            library_dir="${fuma_ax_webtoolkit_library_dir_path}"])

AC_ARG_WITH([mysql],
        [AS_HELP_STRING([--with-mysql@<:@=ARG@:>@],
            [use Wt MySQL Database backend,
            @<:@ARG=yes@:>@ ])],
        [fuma_ax_with_mysql=${withval}], [fuma_ax_with_mysql="no";])

AC_ARG_WITH([postgres],
        [AS_HELP_STRING([--with-postgres@<:@=ARG@:>@],
            [use Wt PostgreSQL Database backend,
            @<:@ARG=no@:>@ ])],
        [fuma_ax_with_postgres=${withval}], [fuma_ax_with_postgres="no";])

AC_ARG_WITH([sqlite3],
        [AS_HELP_STRING([--with-sqlite3@<:@=ARG@:>@],
            [use Wt SQLITE3 Database backend,
            @<:@ARG=no@:>@ ])],
        [fuma_ax_with_sqlite3=${withval}], [fuma_ax_with_sqlite3="yes";])

    AS_IF([test "x$fuma_ax_with_mysql" = "xyes"], [dnl
        fuma_ax_with_sqlite3="no";
        fuma_ax_with_postgres="no";
        fuma_ax_dbo_backend="mysql";])

    AS_IF([test "x$fuma_ax_with_sqlite3" = "xyes"], [dnl
        fuma_ax_with_mysql="no";
        fuma_ax_with_postgres="no";
        fuma_ax_dbo_backend="sqlite3";])

    AS_IF([test "x$fuma_ax_with_postgres" = "xyes"], [dnl
        fuma_ax_with_mysql="no";
        fuma_ax_with_sqlite3="no";
        fuma_ax_dbo_backend="postgres";])

# try paths until we find a match
    dnl setup the search paths
    fuma_ax_webtoolkit_search_paths="
    /usr/local/Cellar/witty/${fuma_ax_desired_webtoolkit_version_str}
    /opt/witty/${fuma_ax_desired_webtoolkit_version_str}
    /home/user/software/witty/${fuma_ax_desired_webtoolkit_version_str}
    /usr/local
    ";

    for search_path in $fuma_ax_webtoolkit_path $fuma_ax_webtoolkit_search_paths;
        do
        FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET([include],[${search_path}/include])

        # use a search path unless the user specified an explict path
                FUMA_AX_SET_WEBTOOLKIT_DIRECTORY_UNLESS_SET([library],[${search_path}/lib])

        # check if the header is present
        fuma_ax_webtoolkit_version_header_found="no"

        AS_IF([test -f "${include_dir}/Wt/Http/Client"],[dnl
            fuma_ax_webtoolkit_version_header_found="yes"

            FUMA_AX_COMPARE_WEBTOOLKIT_HEADER_VERSION([fuma_ax_desired_webtoolkit_version_number],
                [fuma_ax_webtoolkit_version_header_found],
                [include_dir])

            FUMA_AX_CHECK_WEBTOOLKIT_HTTP_LIBRARY([fuma_ax_webtoolkit_http_library_found],[library_dir])
            FUMA_AX_CHECK_WEBTOOLKIT_TEST_LIBRARY([fuma_ax_webtoolkit_test_library_found],[library_dir])

            AS_IF([test "x$fuma_ax_dbo_backend" = "xmysql"],[
                FUMA_AX_CHECK_WEBTOOLKIT_DBO_MYSQL_LIBRARY([fuma_ax_webtoolkit_mysql_backend_found],[library_dir])
                ],[fuma_ax_webtoolkit_mysql_backend_found="no"])

            AS_IF([test "x$fuma_ax_dbo_backend" = "xsqlite3"],[
                FUMA_AX_CHECK_WEBTOOLKIT_DBO_SQLITE3_LIBRARY([fuma_ax_webtoolkit_sqlite3_backend_found],[library_dir])
                ],[fuma_ax_webtoolkit_sqlite3_backend_found="no"])

            AS_IF([test "x$fuma_ax_dbo_backend" = "xpostgres"],[
                FUMA_AX_CHECK_WEBTOOLKIT_DBO_POSTGRES_LIBRARY([fuma_ax_webtoolkit_postgres_backend_found],[library_dir])
                ],[fuma_ax_webtoolkit_postgres_backend_found="no"])

            break])
         done

            AS_IF([test "x${fuma_ax_webtoolkit_http_library_found}" = "xyes"],[dnl
# found MySQL
                AC_MSG_CHECKING(if should enable MySQL database backend for Wt)
                AS_IF([test "x$fuma_ax_dbo_backend x${fuma_ax_webtoolkit_mysql_backend_found}" = "xmysql xyes"],[
                    WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_MYSQL_LIBS}";
                    AC_SUBST([WEBTOOLKIT_DBO_LIBS])
                    fuma_ax_webtoolkit_found="yes"])
                AC_MSG_RESULT([${fuma_ax_webtoolkit_mysql_backend_found}])

# found SQLITE3
                AC_MSG_CHECKING(if should enable SQLITE3 database backend for Wt)
                AS_IF([test "x$fuma_ax_dbo_backend x${fuma_ax_webtoolkit_sqlite3_backend_found}" = "xsqlite3 xyes"],[
                    WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_SQLITE3_LIBS}";
                    AC_SUBST([WEBTOOLKIT_DBO_LIBS])
                    fuma_ax_webtoolkit_found="yes"])
                    AC_MSG_RESULT([${fuma_ax_webtoolkit_sqlite3_backend_found}])

# found PostgreSQL
                AC_MSG_CHECKING(if should enable PostgreSQL database backend for Wt)
                AS_IF([test "x$fuma_ax_dbo_backend x${fuma_ax_webtoolkit_postgres_backend_found}" = "xpostgres xyes"],[
                    WEBTOOLKIT_DBO_LIBS="${WEBTOOLKIT_DBO_POSTGRES_LIBS}";
                    AC_SUBST([WEBTOOLKIT_DBO_LIBS])
                    fuma_ax_webtoolkit_found="yes"])
                    AC_MSG_RESULT([${fuma_ax_webtoolkit_postgres_backend_found}])

        AC_DEFINE([HAVE_WEBTOOLKIT],[1],[define if the Webtoolkit library is available])

                ],
        [fuma_ax_webtoolkit_found="no"])

# perform user supplied action if user indeed supplied it.
    AS_IF([test "x$fuma_ax_webtoolkit_found" = "xyes"],
        [# action on success
        ifelse([$2], , :, [$2])
        ],
        [ # action on failure
        ifelse([$3], , :, [$3])
        ])

    AS_IF([test "x$fuma_ax_webtoolkit_found" = "xyes"], [],[dnl
            AC_ERROR([Could not find WebToolkit library to use]) ])

#---------------------------------------------------------------
# FUMA_AX_WEBTOOLKIT end
#---------------------------------------------------------------
])
