# Makefile.am
AM_DISTCHECK_CONFIGURE_FLAGS = --with-ccache=yes

ACLOCAL_AMFLAGS = -I m4

BUILT_SOURCES = ChangeLog

SUBDIRS = \
 sources \
 tests \
 .

EXTRA_DIST = \
 m4 \
 build-aux \
 scripts \
 autogen.sh \
 ChangeLog

MAINTAINERCLEANFILES = \
 $(top_srcdir)/config.h.in~ \
 $(top_srcdir)/config.h.in \
 $(top_srcdir)/Makefile.in \
 $(top_srcdir)/configure \
 $(top_srcdir)/aclocal.m4 \
 $(top_srcdir)/build-aux/compile \
 $(top_srcdir)/build-aux/config.guess \
 $(top_srcdir)/build-aux/config.h.in \
 $(top_srcdir)/build-aux/config.h.in~ \
 $(top_srcdir)/build-aux/config.sub \
 $(top_srcdir)/build-aux/test-driver \
 $(top_srcdir)/build-aux/depcomp \
 $(top_srcdir)/build-aux/install-sh \
 $(top_srcdir)/build-aux/ltmain.sh \
 $(top_srcdir)/build-aux/missing \
 $(top_srcdir)/m4/ltsugar.m4 \
 $(top_srcdir)/m4/libtool.m4 \
 $(top_srcdir)/m4/ltversion.m4 \
 $(top_srcdir)/m4/lt~obsolete.m4 \
 $(top_srcdir)/m4/ltoptions.m4

# include Coverage targets
include $(top_srcdir)/build-aux/gcov.mk

# include ChangeLog target
include $(top_srcdir)/build-aux/changelog.mk

# include astyle targets
include $(top_srcdir)/build-aux/astyle.mk

dist-hook: ChangeLog

DISTCLEANFILES=ChangeLog
