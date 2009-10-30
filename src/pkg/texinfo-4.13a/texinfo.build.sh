_unpack $P
cd ${P%[a-z]}

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls

make
make DESTDIR=$D install

_doc ABOUT-NLS AUTHORS COPYING INSTALL INTRODUCTION NEWS README README.dev TODO
_descr
_makepkg

