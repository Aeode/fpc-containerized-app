FPC = fpc
SRC = src/main.pas

UNIT_DIRS = $(shell find src -type d)
UNIT_PATHS = $(foreach dir,$(UNIT_DIRS), -Fu$(dir))

DEBUG_OUT = build/debug/main
RELEASE_OUT = build/release/main

DEBUG_FLAGS = -g -gl -O- -Mobjfpc
RELEASE_FLAGS = -O2 -Xs -XX -Mobjfpc -XS -Xt

debug:
	mkdir -p build/debug
	$(FPC) $(DEBUG_FLAGS) $(UNIT_PATHS) $(SRC) -o$(DEBUG_OUT)

release:
	mkdir -p build/release
	$(FPC) $(RELEASE_FLAGS) $(UNIT_PATHS) $(SRC) -o$(RELEASE_OUT)

clean:
	rm -rf build

.PHONY: debug release clean