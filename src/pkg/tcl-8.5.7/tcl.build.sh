_unpack $PN$PV-src
cd tcl$PV/unix

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls

make
make DESTDIR=$D install install-private-headers
ln -s tclsh8.5 $D/ffp/bin/tclsh

cd ..
_doc README license.terms
_descr
_makepkg

