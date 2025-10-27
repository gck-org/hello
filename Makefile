PACKAGE := hello

SRCS := $(wildcard src/*.c) $(wildcard lib/*.c)
OBJS := $(patsubst src/%.c,build/obj/%.o,$(SRCS))

BIN := bin/$(PACKAGE)

COMMIT := $(shell git rev-list --count --all)
FLAGS := -I. -DCOMMIT=$(COMMIT) --std=c2x -pedantic

VERSION := $(shell git describe --tags --always --dirty)
TARBALL := $(PACKAGE)-$(VERSION).tar.gz
RELEASE_FILES := doc src lib COPYING AUTHORS README yait.1 INSTALL Makefile configure config.h

-include config.mak

ifeq ($(wildcard config.mak),)
all:
	@echo "File config.mak not found, run configure"
	@exit 1
else

all: build $(BIN)

build:
	mkdir -p bin
	mkdir -p build/obj

build/obj/%.o: src/%.c config.mak
	$(CC) $(FLAGS) $(CFLAGS) -c $< -o $@

$(BIN): $(OBJS) 
	$(CC) $(FLAGS) $(CFLAGS) $^ -o $@

endif

install: $(BIN)
	cp $(BIN) $(PREFIX)

uninstall:
	$(RM) $(PREFIX)$(PACKAGE)

clean:
	$(RM) -r bin
	$(RM) -r build

distclean: clean
	$(RM) config.mak
	$(RM) $(TARBALL)

release: clean all
	tar -czf $(TARBALL) $(RELEASE_FILES)

.PHONY: all clean distclean install uninstall build release
