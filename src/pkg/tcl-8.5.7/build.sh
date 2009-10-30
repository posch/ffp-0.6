unpack $PN$PV-src
cd tcl$PV/unix

CFLAGS="$FFP_CFLAGS" \
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls

make
make DESTDIR=$D install install-private-headers
ln -s tclsh8.5 $D/ffp/bin/tclsh

cd ..
install_doc README license.terms

