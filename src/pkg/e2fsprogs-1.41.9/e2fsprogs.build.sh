_unpack $P
cd $P

mkdir build
cd build

../configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--enable-elf-shlibs \
	--disable-libblkid --disable-libuuid --disable-fsck --disable-uuid \
	--disable-evms \
	--with-ldopts="$FFP_LDFLAGS" \
	--disable-tls

make \
	LIBUUID="-luuid" STATIC_LIBUUID="-luuid" \
	LIBBLKID="-lblkid" STATIC_LIBBLKID="-lblkid"

make DESTDIR=$D install install-libs

cd ..
_doc COPYING INSTALL INSTALL.elfbin README RELEASE-NOTES SHLIBS
_descr
_makepkg

