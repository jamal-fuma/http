INCLUDE_DIRS	= -I$(top_builddir) \
				  -I$(top_srcdir)/sources/include \
				  -I$(top_srcdir)/tests/include

SOURCE_DEFINES  = -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
				  -D__STDC_LIMIT_MACROS=1 \
				  -DFUMA_BUILD_LABEL="\"${FUMA_BUILD_LABEL}\"" \
				  -DBOOST_SIGNALS_NO_DEPRECATION_WARNING=1

TEST_DEFINES	= $(SOURCE_DEFINES) \
				  -DFIXTURES_DIR="\"${abs_top_srcdir}/tests/fixtures\"" \
				  -DBOOST_TEST_DYN_LINK="1"

 # where there is a choice, we prefer to statically link test cases
LINKER_FLAGS	= -static \
				  $(BOOST_LDFLAGS) \
				  $(PTHREAD_LIBS) \
				  $(POSTGRES_LDFLAGS)
				  $(WEBTOOLKIT_LDFLAGS) \
				  $(COVERAGE_LDFLAGS) \
				  -rdynamic

WARNING_FLAGS	= -Wall -Wextra -pedantic \
		  -Wunused-value \
		  -Wcast-align \
		  -Wno-unused-parameter \
		  -Wunused-variable \
		  -Winit-self \
		  -Wfloat-equal \
		  -Wno-undef \
		  -Wno-shadow \
		  -Wcast-qual \
		  -Wwrite-strings

if FREEBSD
WARNING_FLAGS +=  -ftemplate-backtrace-limit=0
endif

COMPILE_FLAGS	= $(INCLUDE_DIRS) \
				  $(BOOST_CPPFLAGS) \
				  $(PTHREAD_CFLAGS) \
				  $(POSTGRES_CPPFLAGS) \
				  $(WEBTOOLKIT_CPPFLAGS) \
				  $(SOURCE_DEFINES) \
				  $(TEST_DEFINES) \
				  $(WARNING_FLAGS)

LINKER_LIBS		= $(BOOST_UNIT_TEST_FRAMEWORK_LIB) \
				  $(BOOST_SYSTEM_LIB) $(BOOST_IOSTREAM_LIB) \
				  $(BOOST_PROGRAM_OPTIONS_LIB) \
				  $(BOOST_REGEX_LIB) \
				  $(BOOST_FILESYSTEM_LIB) \
				  $(WEBTOOLKIT_HTTP_LIBS) \
				  $(WEBTOOLKIT_DBO_LIBS) \
				  $(POSTGRES_PQ_LIBS)
