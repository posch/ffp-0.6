v=$(echo $PV | tr '_' '-')

_unpack dialog-$v
cd dialog-$v

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--disable-static \
	--with-ncursesw \
	--enable-widec

make
make DESTDIR=$D install

mkdir -p $D/ffp/etc
cat samples/slackware.rc >$D/ffp/etc/dialogrc

_doc CHANGES COPYING README VERSION dialog.lsm
_descr
_makepkg

