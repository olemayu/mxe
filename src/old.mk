# old

PKG            := old
$(PKG)_VERSION := 0.17
$(PKG)_SUBDIR  := old-$($(PKG)_VERSION)
$(PKG)_FILE    := old-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE := http://blitiri.com.ar/p/old/
$(PKG)_URL     := http://blitiri.com.ar/p/old/files/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS    := gcc

define $(PKG)_UPDATE
    wget -q -O- 'http://blitiri.com.ar/p/old/' | \
    grep 'old-' | \
    $(SED) -n 's,.*old-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && $(TARGET)-gcc -O3 -Iinclude -c -o libold.o lib/libold.c
    cd '$(1)' && $(TARGET)-ar cr libold.a libold.o
    $(TARGET)-ranlib '$(1)/libold.a'
    install -d '$(PREFIX)/$(TARGET)/lib'
    install -m644 '$(1)/libold.a' '$(PREFIX)/$(TARGET)/lib/'
    install -d '$(PREFIX)/$(TARGET)/include'
    install -m644 '$(1)/lib/old.h' '$(PREFIX)/$(TARGET)/include/'
endef
