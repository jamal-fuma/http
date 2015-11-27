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
AC_DEFUN([FUMA_AX_SAVE_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_SAVE_FLAGS start
#---------------------------------------------------------------
# save original flags
        CPPFLAGS_$1="$CPPFLAGS";
        LDFLAGS_$1="$LDFLAGS";
        LIBS_$1="$LIBS";
#---------------------------------------------------------------
# FUMA_AX_SAVE_FLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_PUSH_CPPFLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_PUSH_CPPFLAGS start
#---------------------------------------------------------------
# append to original flags
        CPPFLAGS="$CPPFLAGS_$1 $2";
        export CPPFLAGS;
#---------------------------------------------------------------
# FUMA_AX_PUSH_CPPFLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_PUSH_LDFLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_PUSH_LDFLAGS start
#---------------------------------------------------------------
# append to original flags
        LDFLAGS="$LDFLAGS_$1 $2";
        export LDFLAGS;
#---------------------------------------------------------------
# FUMA_AX_PUSH_LDFLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_PUSH_LIBS],[dnl
#---------------------------------------------------------------
# FUMA_AX_PUSH_LIBS start
#---------------------------------------------------------------
# append to original flags
        LIBS="$LIBS_$1 $2";
        export LIBS;
#---------------------------------------------------------------
# FUMA_AX_PUSH_LIBS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_POP_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_POP_FLAGS start
#---------------------------------------------------------------
# restore original flags
       FUMA_AX_PUSH_CPPFLAGS([$1],[])
       FUMA_AX_PUSH_LDFLAGS([$1],[])
       FUMA_AX_PUSH_LIBS([$1],[])
#---------------------------------------------------------------
# FUMA_AX_POP_FLAGS end
#---------------------------------------------------------------
        ])
