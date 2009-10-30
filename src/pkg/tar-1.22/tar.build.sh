_unpack $P
cd $P
    
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--libexecdir=/ffp/sbin \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls
    
make
make DESTDIR=$D install
    
_doc ABOUT-NLS AUTHORS COPYING NEWS PORTS README THANKS TODO
_descr
_makepkg

