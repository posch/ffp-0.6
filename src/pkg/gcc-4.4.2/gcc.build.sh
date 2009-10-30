GCC_EXTRA_CONFIG="--disable-multilib --with-float=soft"

set -e
_unpack $P
cd $P

patch -p1 -i $X/patches/302-c99-snprintf.patch
# need patch for softfloat on ARM OABI
patch -p1 -i $X/patches/810-arm-softfloat-libgcc.patch

# system header dir is /ffp/include
sed -i '/^NATIVE_SYSTEM_HEADER_DIR/ s,/usr/,/ffp/,' gcc/Makefile.in

# dynamic linker is /ffp/lib/ld-uClibc.so.0
sed -i '/UCLIBC_DYNAMIC_LINKER/ s,/lib/ld-uClibc.so.0,/ffp&,' gcc/config/linux.h

# standard include dir is /ffp/include, standard startfile prefix is /ffp/lib/
cat >>gcc/config/linux.h <<EOF
#undef  STANDARD_INCLUDE_DIR
#define STANDARD_INCLUDE_DIR        "/ffp/include/"
#undef  STANDARD_STARTFILE_PREFIX_1
#define STANDARD_STARTFILE_PREFIX_1 "/ffp/lib/"
#undef  STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_2 ""
EOF

mkdir -p ../build
cd ../build

../$P/configure \
    --prefix=/ffp \
    --build=$GNU_BUILD --host=$GNU_TARGET --target=$GNU_TARGET \
    --enable-shared \
    --disable-nls \
    --infodir=$infodir --mandir=$mandir \
    --disable-libgomp --disable-libmudflap --disable-libssp \
    --enable-languages=c,c++ --enable-__cxa_atexit \
    --enable-threads=posix \
    --enable-long-long --enable-c99 \
    --disable-libstdcxx-pch \
    $GCC_EXTRA_CONFIG

make configure-host
make \
	BOOT_LDFLAGS="$FFP_LDFLAGS" \
	LDFLAGS_FOR_TARGET="$FFP_LDFLAGS"

# build fails when using:
#    BOOT_CFLAGS="$FFP_CFLAGS" \
#    BOOT_LDFLAGS="$FFP_LDFLAGS" \
#    CFLAGS_FOR_TARGET="$FFP_CFLAGS" \
#    LDFLAGS_FOR_TARGET="$FFP_LDFLAGS"

make DESTDIR=$D install

ln -s gcc $D/ffp/bin/cc

cd ../$P
_doc ABOUT-NLS COPYING* ChangeLog LAST_UPDATED MAINTAINERS NEWS README
_descr
_makepkg

# -solibs package
d=$D
_setpkg -solibs
mkdir -p $D/ffp/lib
cp -av $d/ffp/lib/*.so* $D/ffp/lib
_descr
_makepkg

