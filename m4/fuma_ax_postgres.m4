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
#   FUMA_AX_POSTGRES([MINIMUM-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Test for the PostgreSQL C++ libraries of a particular version (or newer)
#
#   This macro calls:
#
#     AC_SUBST(POSTGRES_CPPFLAGS) / AC_SUBST(POSTGRES_LDFLAGS)
#     AC_SUBST([POSTGRES_PQ_LIBS])
#
#   And sets:
#
#     HAVE_POSTGRES
#     HAVE_POSTGRES_PQ
#
# LICENSE
# (c) FumaSoftware 2015

AC_DEFUN_ONCE([FUMA_AX_POSTGRES],[dnl
#---------------------------------------------------------------
# FUMA_AX_POSTGRES start
#---------------------------------------------------------------
	#set defaults for our shell variables
	fuma_ax_postgres_default_version="9.4.0"
	fuma_ax_postgres_default_library_ext="${fuma_ax_default_library_ext}"
	fuma_ax_postgres_user_version="$1"
	fuma_ax_postgres_found="no"
	fuma_ax_postgres_required="yes"
	fuma_ax_with_postgres_library_dir="yes"
	fuma_ax_with_postgres_include_dir="yes"

	# compare supplied version against the empty string,
	# if the caller supplied a version we use that otherwise we use fuma_ax_postgres_default_version
	FUMA_AX_SET_POSTGRES_VERSION([ifelse([${fuma_ax_postgres_user_version}],[],
			["${fuma_ax_postgres_default_version}"],
			["${fuma_ax_postgres_user_version}"])], [desired_postgres])

	# Check whether --with-postgres was given.
	AC_ARG_WITH([postgres], [dnl
			AS_HELP_STRING([--with-postgres=@<:@ARG@:>@],[use PostgreSQL from a standard location (ARG=yes),
				from the specified location (ARG=<path>), or disable it (ARG=no) @<:@ARG=yes@:>@ ])],
			[fuma_ax_with_postgres=${withval}],
			[fuma_ax_with_postgres="${fuma_ax_postgres_required}"])

	# export path of PostgreSQL top level directory
	FUMA_AX_SET_POSTGRES_PATH([fuma_ax_with_postgres],[postgres])

	# allow overriding paths for location of PostgreSQL
	AS_IF([test -d "${fuma_ax_postgres_path}"], [dnl
		fuma_ax_postgres_include_dir_path="${fuma_ax_postgres_path}/include"
		fuma_ax_postgres_library_dir_path="${fuma_ax_postgres_path}/lib"])

	# Check whether --with-postgres-include-dir was given.
	AC_ARG_WITH([postgres-include-dir], [dnl
			AS_HELP_STRING([--with-postgres-include-dir=@<:@ARG@:>@],[override include path for PostgreSQL (ARG=path)])],
			[fuma_ax_with_postgres_include_dir=${withval}],
			[fuma_ax_with_postgres_include_dir="${fuma_ax_postgres_required}"])

	# export include path for PostgreSQL
	FUMA_AX_SET_POSTGRES_PATH([fuma_ax_with_postgres_include_dir],[postgres_include_dir])

	# allow overriding include paths for location of PostgreSQL
	AS_IF([test -d "${fuma_ax_postgres_include_dir_path}"], [dnl
			include_dir="${fuma_ax_postgres_include_dir_path}"])

	# Check whether --with-postgres-library-dir was given.
	AC_ARG_WITH([postgres-library-dir], [dnl
			AS_HELP_STRING([--with-postgres-library-dir=@<:@ARG@:>@],[override library path for PostgreSQL (ARG=path)])],
			[fuma_ax_with_postgres_library_dir=${withval}],
			[fuma_ax_with_postgres_library_dir="${fuma_ax_postgres_required}"])

	# export library path for PostgreSQL
	FUMA_AX_SET_POSTGRES_PATH([fuma_ax_with_postgres_library_dir],[postgres_library_dir])

	# allow overriding library paths for location of PostgreSQL
	AS_IF([test -d "${fuma_ax_postgres_library_dir_path}"], [dnl
			library_dir="${fuma_ax_postgres_library_dir_path}"])

# try paths until we find a match
	dnl setup the search paths
	fuma_ax_postgres_search_paths="
	/usr/local/Cellar/postgresql/${fuma_ax_desired_postgres_version_str}
	/opt/postgres/${fuma_ax_desired_postgres_version_str}
	/home/user/software/postgres/${fuma_ax_desired_postgres_version_str}
	";

	for search_path in $fuma_ax_postgres_path $fuma_ax_postgres_search_paths;
	do
		FUMA_AX_SET_POSTGRES_DIRECTORY_UNLESS_SET([include],[${search_path}/include])

		# use a search path unless the user specified an explict path
		FUMA_AX_SET_POSTGRES_DIRECTORY_UNLESS_SET([library],[${search_path}/lib])

		# check if the header is present
		fuma_ax_postgres_version_header_found="no"

		AS_IF([test -f "${include_dir}/libpq-fe.h"],[dnl
			fuma_ax_postgres_version_header_found="yes"

			FUMA_AX_COMPARE_POSTGRES_HEADER_VERSION([fuma_ax_desired_postgres_version_str],
				[fuma_ax_postgres_version_header_found],
				[include_dir])

			fuma_ax_postgres_found="no"
			fuma_ax_postgres_pq_library_found="no"
			FUMA_AX_CHECK_POSTGRES_PQ_LIBRARY([fuma_ax_postgres_pq_library_found],[library_dir])
		])

		AS_IF([test "x${fuma_ax_postgres_pq_library_found}" = "xyes"],[dnl
			AC_DEFINE([HAVE_POSTGRES],[1],[define if the PostgreSQL library is available])
			fuma_ax_postgres_found="yes"
			break])
	done

	AC_MSG_RESULT([${fuma_ax_postgres_found}])

# perform user supplied action if user indeed supplied it.
	AS_IF([test "x$fuma_ax_postgres_found" = "xyes"],
		[# action on success
		ifelse([$2], , :, [$2])
		],
		[ # action on failure
		ifelse([$3], , :, [$3])
		])

	AS_IF([test "x$fuma_ax_postgres_found" = "xyes"], [],[dnl
			AC_ERROR([Could not find PostgreSQL library to use]) ])
#---------------------------------------------------------------
# FUMA_AX_POSTGRES end
#---------------------------------------------------------------
])
