CC = g++
CCFLAGS = -g -Wall
## for serial library in current folder
INCLUDE = -Ilibserial/include
LIBS = -Llibserial -lserial
LIBSERIAL = libserial/libserial.so
## for libserialport
PKG_CONFIG = pkg-config
INCLUDE += $(shell $(PKG_CONFIG) --cflags libserialport)
LIBS += $(shell $(PKG_CONFIG) --libs libserialport)

HEADERS = $(wildcard *.h *.hpp)
SOURCES = $(wildcard *.cpp *.cc)
BINARIES = $(SOURCES:.cpp=)

.PHONY: all clean rebuild print

all: $(BINARIES)

%: %.cpp $(HEADERS) $(LIBSERIAL)
	$(CC) $(CCFLAGS) $(INCLUDE) $(LIBS) -o $@ $<

clean:
	rm -f $(BINARIES)
	rm -rf *.dSYM

rebuild: clean all

lib libserial: $(LIBSERIAL)

$(LIBSERIAL):
	cd libserial && make libserial

print:
	@echo HEADERS: $(HEADERS)
	@echo SOURCES: $(SOURCES)
	@echo BINARIES: $(BINARIES)
