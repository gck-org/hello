PREFIX = /usr/bin/

HELLO_SRCS := $(wildcard src/*.c)
HELLO_OBJS := $(patsubst src/%.c,build/obj/%.o,$(HELLO_SRCS))

HELLO := bin/hello

ALLOWED_DIRS = doc include man src tools
DISTDIRS := $(sort $(shell find . -maxdepth 1 -type d -not -name '.' -printf '%f\n'))

-include config.mak

ifeq ($(wildcard config.mak),)
all:
	@echo "File config.mak not found, run configure"
	@exit 1
else

all: build $(HELLO)

build:
	mkdir -p bin
	mkdir -p build/obj

build/obj/%.o: src/%.c config.mak
	$(CC) $(CFLAGS) -DCOMMIT=$(shell git rev-list --count --all) -Iinclude -c $< -o $@

$(HELLO): $(HELLO_OBJS) 
	$(CC) $(CFLAGS) -Iinclude -DCOMMIT=$(shell git rev-list --count --all) $^ -o $@

endif

install: $(HELLO)
	cp $(HELLO) $(PREFIX)

uninstall:
	$(RM) $(PREFIX)hello

clean:
	$(RM) -r bin
	$(RM) -r build

distclean: clean
	$(RM) config.mak

syntax-check:
	@set -e; \
	fail=0; \
	for f in $(HELLO_SRCS); do \
		echo "$$f"; \
		if ! $(CC) $(CFLAGS) -fsyntax-only $$f; then \
			fail=1; \
		fi
	done; \
	if test $$fail -ne 0; then \
		exit 1;
	fi

distcheck: distclean
	@set -e; \
	for d in $(DESTDIRS); do \
		case " $(ALLOWED_DIRS) " in \
			*" $$d "*) ;; \
			*) echo "Error unexpected directory '$$d'"; exit 1 ;; \
		esac; \
	done

.PHONY: all clean dist-clean install uninstall build syntax-check distcheck
