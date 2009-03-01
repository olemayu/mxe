# SDL

PKG            := sdl
$(PKG)_VERSION := 1.2.11
$(PKG)_SUBDIR  := SDL-$($(PKG)_VERSION)
$(PKG)_FILE    := SDL-$($(PKG)_VERSION).tar.gz
$(PKG)_WEBSITE := http://libsdl.org/
$(PKG)_URL     := http://libsdl.org/release/$($(PKG)_FILE)
$(PKG)_DEPS    := gcc libiconv

define $(PKG)_UPDATE
    wget -q -O- 'http://libsdl.org/release/changes.html' | \
    $(SED) -n 's,.*SDL \([0-9][^>]*\) Release Notes.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    $(SED) 's,-mwindows,-lwinmm -mwindows,' -i '$(1)/configure'
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --disable-debug \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
