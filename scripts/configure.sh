#!/bin/sh

# workout the absolute path to the checkout directory
abspath()
{
    case "${1}" in
        [./]*)
            local ABSPATH="$(cd ${1%/*}; pwd)/${1##*/}"
            echo "${ABSPATH}"
            ;;
        *)
            echo "${PWD}/${1}"
            ;;
    esac
}

SCRIPT=$(abspath ${0})
SCRIPTPATH=`dirname ${SCRIPT}`
ROOTPATH=`dirname ${SCRIPTPATH}`
export PROJECT_ROOT=${ROOTPATH}

#  CC          C compiler command
#  CFLAGS      C compiler flags
#  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a nonstandard directory <lib dir>
#  LIBS        libraries to pass to the linker, e.g. -l<library>
#  CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if you have headers in a nonstandard directory <include dir>
#  CPP         C preprocessor
#  CXX         C++ compiler command
#  CXXFLAGS    C++ compiler flags
#  CXXCPP      C++ preprocessor

if [ "${1}" = "bsd" ];
then
        ${PROJECT_ROOT}/configure \
                --prefix="/home/user/software" \
                --enable-maintainer-mode \
                --with-ccache=yes \
                --enable-silent-rules ;
fi

if [ "${1}" = "osx" ];
then
        CTAGS=/usr/local/bin/ctags \
        CTAGSFLAGS="-R --tag-relative=yes --exclude=.git --exclude=build" \
        ASTYLE_TOOL=/usr/local/Cellar/astyle/2.04/bin/astyle \
        ${PROJECT_ROOT}/configure \
            --enable-maintainer-mode \
            --with-ccache=yes \
            --enable-silent-rules ;
fi

if [ "${1}" = "linux" ];
then
        ${PROJECT_ROOT}/configure \
                --enable-maintainer-mode \
                --enable-debug \
                --enable-silent-rules \
                --with-ccache=yes;
fi

if [ "${1}" = "profile" ];
then
        ${PROJECT_ROOT}/configure \
                --enable-maintainer-mode \
                --enable-debug \
                --enable-silent-rules \
                --enable-gcov;
fi

if [ "${1}" = "centos" ];
then
        ${PROJECT_ROOT}/configure \
                --prefix="/home/user/software" \
                --enable-maintainer-mode \
                --enable-silent-rules \
                --with-boost=/home/user/software/boost/current \
                --with-boost-libdir=/home/user/software/boost/current/lib \
                --with-ccache=yes ;
fi
