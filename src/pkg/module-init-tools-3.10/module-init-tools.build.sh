_unpack $P
cd $P

#patch -p1 -i $X/module-init-tools-3.6-man_pages-1.patch
#sed -i '1 s,^,#define CONFIG_NO_BACKWARDS_COMPAT\n,' backwards_compat.c

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--enable-zlib

make
make DESTDIR=$D INSTALL=install mandir=$mandir install

_doc AUTHORS CODING COPYING FAQ INSTALL NEWS README TODO
_descr
_makepkg

