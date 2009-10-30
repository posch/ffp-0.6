_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--libexecdir=/ffp/lib/findutils \
	--localstatedir=/ffp/var/lib/locate
    
make
make DESTDIR=$D install
    
_doc AUTHORS COPYING NEWS README THANKS TODO
_descr
_makepkg

