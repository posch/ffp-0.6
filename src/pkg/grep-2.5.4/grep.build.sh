set -e
_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
MISSING=true \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls \
	--disable-perl-regexp
    
make
make DESTDIR=$D install
    
_doc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README THANKS TODO
_descr
_makepkg

