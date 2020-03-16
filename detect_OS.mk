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