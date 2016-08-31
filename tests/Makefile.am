# tests/Makefile.am

SUBDIRS = \
 include \
 lib \
 src \
 .

EXTRA_DIST = fixtures

# test executables to run as a suite
TESTS = \
	lib/test_build$(EXEEXT) \
	src/test_build$(EXEEXT) \
	src/test_basic_request$(EXEEXT) \
	src/test_basic_response$(EXEEXT) \
	src/test_headers$(EXEEXT) \
	src/test_parser_message_state$(EXEEXT)

MAINTAINERCLEANFILES = \
 $(top_srcdir)/tests/Makefile.in
