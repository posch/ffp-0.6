_unpack $P
cd $P
    
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls
    
make
make DESTDIR=$D install
    
_doc AUTHORS BUGS COPYING* ChangeLog* NEWS README THANKS TODO
_descr
_makepkg

