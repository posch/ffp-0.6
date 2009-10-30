_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir --docdir=$docdir/$P \
	--enable-shared --disable-static \
	--program-prefix= --program-suffix= 
    
make
make DESTDIR=$D install
rmdir $D/ffp/share || true

_doc ABOUT-NLS AUTHORS COPYING* ChangeLog INSTALL NEWS README* THANKS doc/*.txt
_descr
_makepkg tgz

