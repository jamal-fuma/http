# tests/src/Makefile.am

SUBDIRS = \
 .

# build a unit test
check_PROGRAMS = \
    test_build

# pull in common test flags
include $(top_srcdir)/build-aux/test_common.mk

# name our test suite adding any test specific flags
AM_CPPFLAGS = $(COMPILE_FLAGS) -DBOOST_TEST_MODULE="SRC"
AM_LDFLAGS  = $(LINKER_FLAGS)

# add a link dependancy by adding something like the following above LINKER_LIBS
# $(top_builddir)/sources/lib/libSomething.la
test_build_LDADD = \
		   $(LINKER_LIBS)

# test sources
test_build_SOURCES = test_build.cpp
