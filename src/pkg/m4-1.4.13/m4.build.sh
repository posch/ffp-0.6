set -e
_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls \
	--enable-threads

make
make DESTDIR=$D install

_doc AUTHORS BACKLOG ChangeLog COPYING INSTALL NEWS README THANKS TODO
_descr
_makepkg

