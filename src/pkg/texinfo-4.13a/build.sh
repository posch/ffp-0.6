unpack $P

cd ${P%[a-z]}

CFLAGS="$FFP_CFLAGS" \
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls

make
make DESTDIR=$D install

install_doc ABOUT-NLS AUTHORS COPYING INSTALL INTRODUCTION NEWS README README.dev TODO

