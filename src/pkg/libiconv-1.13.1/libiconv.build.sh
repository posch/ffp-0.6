_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--docdir=$docdir/$P
    
make
make DESTDIR=$D install
    
_doc ABOUT-NLS AUTHORS COPYING* DESIGN INSTALL.generic NEWS NOTES PORTS README \
	THANKS DEPENDENCIES HACKING
_descr
_makepkg

