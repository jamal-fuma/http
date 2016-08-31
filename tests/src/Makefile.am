# tests/src/Makefile.am

SUBDIRS = \
 .

# build a unit test
check_PROGRAMS = \
	test_basic_request \
	test_basic_response \
	test_headers \
	test_parser_message_state


# pull in common test flags
include $(top_srcdir)/build-aux/test_common.mk

# name our test suite adding any test specific flags
AM_CPPFLAGS = $(COMPILE_FLAGS) -DBOOST_TEST_MODULE="SRC"
AM_LDFLAGS  = $(LINKER_FLAGS)

test_parser_message_state_LDADD = \
		   $(LINKER_LIBS)

# test sources
test_parser_message_state_SOURCES = test_parser_message_state.cpp

test_headers_LDADD = \
		   $(LINKER_LIBS)

# test sources
test_headers_SOURCES = test_headers.cpp

test_basic_response_LDADD = \
		   $(LINKER_LIBS)

# test sources
test_basic_response_SOURCES = test_basic_response.cpp

test_basic_request_LDADD = \
		   $(LINKER_LIBS)

# test sources
test_basic_request_SOURCES = test_basic_request.cpp
