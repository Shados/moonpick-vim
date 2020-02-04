MOONC?=moonc
BUSTED?=busted
LUAROCKS?=luarocks
ESCALATE?=sudo
LUA?=luajit
LUA_VERSION=5.1

MOON_DIR=moon
LUA_OUT_DIR=lua
TEST_DIR=test

MOON_FILES:=$(shell find $(MOON_DIR) -name '*.moon')
LUA_FILES:=$(patsubst moon/%,lua/%,$(patsubst %.moon,%.lua,$(MOON_FILES)))

PREFIX?=/usr/local
BINDIR?=$(PREFIX)/bin
LUA_SHARE_DIR?=$(PREFIX)/lib/lua/$(LUA_VERSION)

.PHONY: all install clean test watch

all: bin/moonpick-vim

bin/moonpick-vim: bin/moonpick-vim.moon $(LUA_FILES)
	echo "#!/usr/bin/env $(LUA)" > $@
	$(MOONC) $< -p >> $@
	chmod +x $@

build: $(LUA_FILES)

# $(@D) == lua/sub/directories
lua/%.lua: moon/%.moon
	@test -d $(@D) || mkdir -pm 755 $(@D)
	$(MOONC) $< -o $@

local: build
	$(LUAROCKS) make --force --local moonpick-vim-scm-1.rockspec

global: build
	$(ESCALATE) $(LUAROCKS) make moonpick-vim-scm-1.rockspec

watch: build
	inotifywait -r bin/*.moon moon -m --event close_write 2>/dev/null | while read ev; do make; done

install: bin/moonpick-vim
	@test -d $(LUA_SHARE_DIR) || mkdir -pm 755 $(LUA_SHARE_DIR)
	@test -d $(BINDIR) || mkdir -pm 755 $(BINDIR)
	cp -rf $(LUA_OUT_DIR)/* $(LUA_SHARE_DIR)/
	cp $< "$(BINDIR)"/

test:
	$(BUSTED) --pattern=_spec $(TEST_DIR)

clean:
	rm -f $(LUA_FILES)
