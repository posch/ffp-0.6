unpack $P
cd $P
	
CFLAGS="$FFP_CFLAGS" \
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls

make
make DESTDIR=$D install

install_doc README ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS THANKS TODO

