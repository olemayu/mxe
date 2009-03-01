# GCC g++

PKG            := gcc-g++
$(PKG)_VERSION := 4.3.3
$(PKG)_SUBDIR  := gcc-$($(PKG)_VERSION)
$(PKG)_FILE    := gcc-g++-$($(PKG)_VERSION).tar.bz2
$(PKG)_WEBSITE := http://gcc.gnu.org/
$(PKG)_URL     := http://$(SOURCEFORGE_MIRROR)/tdm-gcc/$($(PKG)_FILE)
$(PKG)_DEPS    :=

define $(PKG)_UPDATE
    wget -q -O- 'http://sourceforge.net/project/showfiles.php?group_id=200665&package_id=238462' | \
    grep 'gcc-g++-' | \
    $(SED) -n 's,.*gcc-g++-\([4-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef
