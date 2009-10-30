config_set() {
    sed -i "s,^$1=.*,$1=\"$2\"," .config
}
config_enable() {
    sed -i "s,^# $1 is not set,$1=y," .config
}
config_disable() {
    sed -i "s,$1=y,# $1 is not set," .config
}

_unpack uClibc-$PV
cd uClibc-$PV

for p in $X/patches/*.patch; do
	patch -p1 -i $p
done

cat $X/$FFP_ARCH-uClibc.config >.config

# custom prefix
config_set KERNEL_HEADERS "/ffp/include"
config_set SHARED_LIB_LOADER_PREFIX "/ffp/lib"
config_set RUNTIME_PREFIX "/ffp"
config_set DEVEL_PREFIX "/ffp"

# native build
config_set CROSS_COMPILER_PREFIX ""

# GNU sed needs this, testcase: sed 's/^/| /' ...
config_enable "MALLOC_GLIBC_COMPAT"

# gdb needs libthread_db
config_enable "PTHREADS_DEBUG_SUPPORT"

# GNU make needs GNU glob
config_enable "UCLIBC_HAS_GLOB"
config_enable "UCLIBC_HAS_GNU_GLOB"

# set LDFLAGS for utils
sed -i "/^CFLAGS-utils/ s@\$@ ${FFP_LDFLAGS}@" utils/Makefile.in

# remove usr/lib from ldconfig
sed -i.orig 's,scan_dir.*usr/,//&,' utils/ldconfig.c

# remove usr/lib from ldd and dl-elf
sed -i.orig 's,UCLIBC_RUNTIME_PREFIX "usr/lib",,' \
    utils/ldd.c ldso/ldso/dl-elf.c

# fix install_utils paths
sed -i 's,usr/,,' utils/Makefile.in

# set LDFLAGS for libs
sed -i "/-soname/ s@ -Wl,@ ${FFP_LDFLAGS}&@" Makerules

yes '' | make V=1  oldconfig
make V=1 UCLIBC_EXTRA_LDFLAGS="$FFP_LDFLAGS"
make V=1 UCLIBC_EXTRA_LDFLAGS="$FFP_LDFLAGS" PREFIX=$D install utils install_utils

# don't install readelf, but use the binutils readelf
rm -f $D/ffp/bin/readelf

_doc COPYING* INSTALL MAINTAINERS README TODO docs/PORTING docs/*.txt
_descr
_makepkg

# uClibc-solibs package
_setpkg -solibs
make V=1 UCLIBC_EXTRA_LDFLAGS="$FFP_LDFLAGS" PREFIX=$D install_runtime install_utils
_descr
_makepkg
