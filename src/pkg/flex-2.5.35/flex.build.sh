_unpack $P
cd $P

# remove hard-coded /usr/include from Makefile
sed -i "s/-I@includedir@//g" Makefile.in

CC="gcc -fPIC"

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls

make CC="$CC" libfl.a
make
make DESTDIR=$D install

_doc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README* THANKS TODO
_descr
_makepkg

