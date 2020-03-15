CC = g++
CCFLAGS = -Iinclude
RM = rm -f

.PHONY: lib libserial print

## ref: https://stackoverflow.com/questions/3774568/makefile-issue-smart-way-to-scan-directory-tree-for-c-files
# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
# recursively find all files that match a pattern
SERIAL_SOURCES := $(call rwildcard,src/,*.cc)
SERIAL_HEADERS := $(call rwildcard,include/,*.h)
SERIAL_LIB = libserial.so

## ref: https://stackoverflow.com/questions/714100/os-detecting-makefile
## get OS name
ifeq ($(OS),Windows_NT)
	detect_OS := Windows_NT
else
	detect_OS := $(shell uname -s)
# 	detect_OS := $(shell uname 2>/dev/null || echo Unknown)
## see for more uname results: https://en.wikipedia.org/wiki/Uname
	detect_OS := $(patsubst CYGWIN%,CYGWIN,$(detect_OS))
	detect_OS := $(patsubst MSYS%,MSYS,$(detect_OS))
	detect_OS := $(patsubst MINGW32%,MINGW32,$(detect_OS))
	detect_OS := $(patsubst MINGW64%,MINGW64,$(detect_OS))
endif
## set CCFLAGS
ifeq ($(detect_OS),Windows_NT)
	CCFLAGS += -D _WIN32
	RM = del
endif
ifeq ($(detect_OS),MINGW32)
	CCFLAGS += -D _WIN32
	CCFLAGS += -D __MINGW32__
	RM = del
endif
ifeq ($(detect_OS),Darwin)
	CCFLAGS += -D __APPLE__
	CCFLAGS += -framework CoreFoundation
	CCFLAGS += -framework IOKit
endif
ifeq ($(detect_OS),Linux)
	CCFLAGS += -D __linux__
endif
ifeq ($(detect_OS),FreeBSD)
	CCFLAGS += -D __FreeBSD__
endif
ifeq ($(detect_OS),OpenBSD)
	CCFLAGS += -D __OpenBSD__
endif

all lib libserial: $(SERIAL_LIB)

$(SERIAL_LIB): $(SERIAL_SOURCES)
	$(CC) $(CCFLAGS) -fPIC -shared -o $@ $^

clean:
	$(RM) libserial.so

print:
	@echo Compile details:
	@echo CC: $(CC)
	@echo OS: $(detect_OS)
	@echo CCFLAGS: $(CCFLAGS)
	@echo SERIAL_HEADERS: $(SERIAL_HEADERS)
	@echo SERIAL_SOURCES: $(SERIAL_SOURCES)
