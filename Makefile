#
#   Makefile for hello (requires GNU make)
#
#
#   LICENSE: BSD-3-Clause
#
#   Copyright (c) 2025 GCK
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

PACKAGE := hello

SRCS := $(wildcard src/*.c) $(wildcard lib/*.c)
OBJS := $(patsubst src/%.c,build/obj/%.o,$(SRCS))

BIN := bin/$(PACKAGE)

COMMIT := $(shell git rev-list --count --all)
FLAGS := -I. -DCOMMIT=$(COMMIT) --std=c2x -pedantic

VERSION := $(shell git describe --tags --always --dirty)
TARBALL := $(PACKAGE)-$(VERSION).tar.gz
RELEASE_FILES := doc src lib COPYING AUTHORS README hello.1 INSTALL Makefile configure config.h

-include config.mak

ifeq ($(wildcard config.mak),)
all:
	@echo "File config.mak not found, run configure"
	@exit 1
else

all: build $(BIN) doc

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

doc:
	$(MAKE) -C doc all

uninstall:
	$(RM) $(PREFIX)$(PACKAGE)

clean:
	$(RM) -r bin
	$(RM) -r build
	$(MAKE) -C doc clean

distclean: clean
	$(RM) config.mak config.status
	$(RM) $(TARBALL)
	$(MAKE) -C doc clean

release: clean all
	tar -czf $(TARBALL) $(RELEASE_FILES)

.PHONY: all clean distclean install uninstall build release doc
