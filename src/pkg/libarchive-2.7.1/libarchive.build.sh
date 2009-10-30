_unpack $P
cd $P

_update_gnu_config

LDFLAGS="$FFP_LDFLAGS" \
MISSING=true \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-static
    
make
make DESTDIR=$D install
    
_doc COPYING INSTALL NEWS PROJECTS README
_descr
_makepkg tgz

