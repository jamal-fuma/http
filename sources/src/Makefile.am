# sources/src/Makefile.am

SUBDIRS = \
.

include $(top_srcdir)/build-aux/source_common.mk

AM_LDFLAGS  = $(LINKER_FLAGS) -L/usr/lib
AM_CPPFLAGS = $(COMPILE_FLAGS)

bin_PROGRAMS = async_client basic_message client server vfs_server 

async_client_SOURCES  = example/async_client/async_client.cpp
vfs_server_SOURCES 	  = example/vfs_server/vfs_server.cpp
basic_message_SOURCES = example/basic_message/basic_message.cpp
server_SOURCES 		  = example/server/server.cpp
client_SOURCES 		  = example/client/client.cpp

async_client_LDADD  = $(LINKER_LIBS)
vfs_server_LDADD 	  = $(LINKER_LIBS)
basic_message_LDADD = $(LINKER_LIBS)
server_LDADD 		  = $(LINKER_LIBS)
client_LDADD 		  = $(LINKER_LIBS)

MAINTAINERCLEANFILES = \
 $(top_srcdir)/sources/src/Makefile.in
