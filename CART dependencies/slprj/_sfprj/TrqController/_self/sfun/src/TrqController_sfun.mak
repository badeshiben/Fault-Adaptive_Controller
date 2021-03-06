# ------------------- Required for MSVC nmake ---------------------------------
# This file should be included at the top of a MAKEFILE as follows:


!include <ntwin32.mak>

MACHINE     = TrqController
TARGET      = sfun
CHART_SRCS 	= \
		c3_TrqController.c
MACHINE_SRC	= TrqController_sfun.c
MACHINE_REG = TrqController_sfun_registry.c
MEX_WRAPPER =
MAKEFILE    = TrqController_sfun.mak
MATLAB_ROOT	= c:\program files\matlab\r2009b
BUILDARGS   =

#--------------------------- Tool Specifications ------------------------------
#
#
MSVC_ROOT1 = $(MSDEVDIR:SharedIDE=vc)
MSVC_ROOT2 = $(MSVC_ROOT1:SHAREDIDE=vc)
MSVC_ROOT  = $(MSVC_ROOT2:sharedide=vc)

# Compiler tool locations, CC, LD, LIBCMD:
CC     = cl.exe
LD     = link.exe
LIBCMD = lib.exe
#------------------------------ Include/Lib Path ------------------------------

USER_INCLUDES   = 
AUX_INCLUDES   = 
ML_INCLUDES     = /I "$(MATLAB_ROOT)\extern\include"
SL_INCLUDES     = /I "$(MATLAB_ROOT)\simulink\include"
SF_INCLUDES     = /I "c:\program files\matlab\r2009b\stateflow\c\mex\include" /I "c:\program files\matlab\r2009b\stateflow\c\debugger\include"

DSP_INCLUDES    =

COMPILER_INCLUDES = /I "$(MSVC_ROOT)\include"

INCLUDE_PATH = $(USER_INCLUDES) $(AUX_INCLUDES) $(ML_INCLUDES) $(SL_INCLUDES) $(SF_INCLUDES) $(DSP_INCLUDES)
LIB_PATH     = "$(MSVC_ROOT)\lib"

CFLAGS = $(COMPFLAGS) /MD
LDFLAGS = /nologo /dll /OPT:NOREF /export:mexFunction
AUXLDFLAGS = 

#----------------------------- Source Files -----------------------------------

REQ_SRCS  = $(MACHINE_SRC) $(MACHINE_REG) $(MEX_WRAPPER) $(CHART_SRCS)

USER_ABS_OBJS =

AUX_ABS_OBJS =

REQ_OBJS = $(REQ_SRCS:.cpp=.obj)
REQ_OBJS2 = $(REQ_OBJS:.c=.obj)
OBJS = $(REQ_OBJS2) $(USER_ABS_OBJS) $(AUX_ABS_OBJS)
OBJLIST_FILE = TrqController_sfun.mol
SFCLIB = "c:\program files\matlab\r2009b\stateflow\c\mex\lib\win32\sfc_mexmsvc71.lib" "c:\program files\matlab\r2009b\stateflow\c\debugger\lib\win32\sfc_debugmsvc71.lib"
AUX_LNK_OBJS =
USER_LIBS =
LINK_MACHINE_LIBS =

DSP_LIBS    =
BLAS_LIBS   = "c:\program files\matlab\r2009b\extern\lib\win32\microsoft\libmwblascompat32.lib"

#--------------------------------- Rules --------------------------------------

MEX_FILE_NAME_WO_EXT = $(MACHINE)_$(TARGET)
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw32
MEX_FILE_CSF =
all : $(MEX_FILE_NAME) $(MEX_FILE_CSF)

MEXLIB = "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libmx.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libmex.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libmat.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libfixedpoint.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libut.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libmwmathutil.lib" "C:\Program Files\MATLAB\R2009b\extern\lib\win32\microsoft\libemlrt.lib"

$(MEX_FILE_NAME) : $(MAKEFILE) $(OBJS) $(SFCLIB) $(AUX_LNK_OBJS) $(USER_LIBS)
	@echo ### Linking ...
	$(LD) $(LDFLAGS) $(AUXLDFLAGS) /OUT:$(MEX_FILE_NAME) /map:"$(MEX_FILE_NAME_WO_EXT).map" $(USER_LIBS) $(SFCLIB) $(AUX_LNK_OBJS) $(MEXLIB) $(LINK_MACHINE_LIBS) $(DSP_LIBS) $(BLAS_LIBS) @$(OBJLIST_FILE)
	@echo ### Created $@

.c.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"

.cpp.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"

