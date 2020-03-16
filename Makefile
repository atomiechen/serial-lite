detect_OS := Unknown
-include detect_OS.mk

## make sure the type of OS is detected correctly
ifneq ($(detect_OS),Unknown)

CP := cp
MKDIR := mkdir

INC_ROOT := serial
INC_DIR := include
LIB_DIR := lib
SRC_DIR := src
SLIB_FILE := libserial.a
DLIB_FILE := libserial.so
SERIAL_SLIB := $(LIB_DIR)/$(SLIB_FILE)
SERIAL_DLIB := $(LIB_DIR)/$(DLIB_FILE)

## examples
EXAMPLES_DIR := examples
STATIC := false

## ref: https://stackoverflow.com/questions/3774568/makefile-issue-smart-way-to-scan-directory-tree-for-c-files
# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
# recursively find all files that match a pattern
SERIAL_HEADERS := $(call rwildcard,$(INC_DIR)/,*.h)
SERIAL_SOURCES := $(call rwildcard,$(SRC_DIR)/,*.cc)
SERIAL_OBJS := $(SERIAL_SOURCES:cc=o)
TMP_SOURCES := $(addprefix ../,$(SERIAL_SOURCES))

CC := g++
CCFLAGS := 
LDFLAGS :=
ifeq ($(detect_OS),Windows_NT)
	CCFLAGS += -D_WIN32
	RM = del
	CP = copy
endif
ifeq ($(detect_OS),MINGW32)
	CCFLAGS += -D_WIN32
	CCFLAGS += -D__MINGW32__
	RM = del
	CP = copy
endif
ifeq ($(detect_OS),Darwin)
	CCFLAGS += -D__APPLE__
	LDFLAGS += -framework CoreFoundation
	LDFLAGS += -framework IOKit
# 	CCFLAGS += -install_name @rpath/libserial.so
	SYSTEM_LIB_PATH = /usr/local/lib/
	SYSTEM_INCLUDE_PATH = /usr/local/include/
endif
ifeq ($(detect_OS),Linux)
	CCFLAGS += -D__linux__
endif
ifeq ($(detect_OS),FreeBSD)
	CCFLAGS += -D__FreeBSD__
endif
ifeq ($(detect_OS),OpenBSD)
	CCFLAGS += -D__OpenBSD__
endif

.PHONY: all slib dlib clean veryclean rebuild info install uninstall examples

all: slib dlib

slib: $(SERIAL_SLIB)

dlib: $(SERIAL_DLIB)

## change directory to make dlib locally
$(SERIAL_DLIB): $(SERIAL_SOURCES) $(LIB_DIR)
	cd $(LIB_DIR) && $(CC) -I../$(INC_DIR) $(CCFLAGS) $(LDFLAGS) -fPIC -shared -o $(DLIB_FILE) $(TMP_SOURCES)

$(SERIAL_SLIB): $(SERIAL_OBJS) $(LIB_DIR)
	$(AR) rvs $@ $(SERIAL_OBJS)

%.o: %.cc
	$(CC) -I$(INC_DIR) $(CCFLAGS) -c $< -o $@

$(LIB_DIR):
	$(MKDIR) $@

clean:
	$(RM) $(SERIAL_OBJS) *.o
	-$(MAKE) -C $(EXAMPLES_DIR) clean

veryclean: clean
	$(RM) $(SERIAL_DLIB) $(SERIAL_SLIB)
	$(RM) -r $(LIB_DIR)

rebuild: veryclean all

info:
	@echo OS: $(detect_OS)
	@echo CC: $(CC)
	@echo CCFLAGS: $(CCFLAGS)
	@echo SERIAL_HEADERS:
	@echo $(SERIAL_HEADERS)
	@echo SERIAL_SOURCES:
	@echo $(SERIAL_SOURCES)
	@echo SERIAL_OBJS:
	@echo $(SERIAL_OBJS)
	@echo INSTALL PATH:
	@echo library: $(SYSTEM_LIB_PATH)
	@echo include: $(SYSTEM_INCLUDE_PATH)

install: all
	$(CP) $(SERIAL_DLIB) $(SYSTEM_LIB_PATH)
	$(CP) $(SERIAL_SLIB) $(SYSTEM_LIB_PATH)
	$(CP) -r $(INC_DIR)/$(INC_ROOT) $(SYSTEM_INCLUDE_PATH)

uninstall:
	$(RM) $(SYSTEM_LIB_PATH)/$(DLIB_FILE)
	$(RM) $(SYSTEM_LIB_PATH)/$(SLIB_FILE)
	$(RM) -r $(SYSTEM_INCLUDE_PATH)/$(INC_ROOT)

examples:
	-$(MAKE) -C $(EXAMPLES_DIR) STATIC=$(STATIC)

else

.PHONY: info

info:
	@echo The OS on this platform is not detected correctly!

endif