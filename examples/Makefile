detect_OS := Unknown
-include ../detect_OS.mk

## make sure the type of OS is detected correctly
ifneq ($(detect_OS),Unknown)

## use static library or dynamic library
STATIC := false
DLIB_FILE := libserial.so
SLIB_FILE := libserial.a
INC_DIR := ../include
LIB_DIR := ../lib

HEADERS := $(wildcard *.h *.hpp)
SOURCES := $(wildcard *.cpp *.cc)
BINARIES := $(SOURCES:.cpp=)
BINARIES := $(BINARIES:.cc=)

CC := g++
CCFLAGS := -I$(INC_DIR)
EXTRA_INPUT := 
ifeq ($(STATIC),false)
	## use dynamic library
	CCFLAGS += -L$(LIB_DIR) -lserial
else
	## use static library
	EXTRA_INPUT += $(LIB_DIR)/$(SLIB_FILE)
	## OS-specific flags
	ifeq ($(detect_OS),Darwin)
		CCFLAGS += -framework CoreFoundation
		CCFLAGS += -framework IOKit
	endif
endif

.PHONY: all clean rebuild info

all: $(BINARIES)

%: %.cpp $(HEADERS)
	$(CC) $(CCFLAGS) -o $@ $< $(EXTRA_INPUT)

%: %.cc $(HEADERS)
	$(CC) $(CCFLAGS) -o $@ $< $(EXTRA_INPUT)

clean:
	rm -f $(BINARIES)

rebuild: clean all

info:
	@echo OS: $(detect_OS)
	@echo CC: $(CC)
	@echo CCFLAGS: $(CCFLAGS)
	@echo STATIC: $(STATIC)
	@echo HEADERS: $(HEADERS)
	@echo SOURCES: $(SOURCES)
	@echo BINARIES: $(BINARIES)

else

.PHONY: info

info:
	@echo The OS on this platform is not detected correctly!

endif