set -e
_unpack $P
cd $P
	
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls

make
make DESTDIR=$D install

_doc README ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS THANKS TODO
_descr
_makepkg

