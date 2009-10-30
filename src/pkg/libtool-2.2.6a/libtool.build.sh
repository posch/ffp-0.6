_unpack $P
cd ${P%[a-z]}

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir

#	--disable-nls
    
make
make DESTDIR=$D install
    
_doc AUTHORS COPYING NEWS README THANKS TODO
_descr
_makepkg

