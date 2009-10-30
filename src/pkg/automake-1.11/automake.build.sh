_unpack $P
cd $P
    
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir --docdir=$docdir/$P \
	--disable-nls
    
make
make DESTDIR=$D install
    
# fix interpreter paths
#sed -i 's@/usr/bin/perl@/ffp/bin/perl@g' $D/ffp/bin/*
    
#mv $D$docdir/$PN $D$docdir/$P

_doc AUTHORS COPYING* NEWS README* THANKS TODO
_descr
_makepkg

