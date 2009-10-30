_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--disable-debug \
	--disable-locale \
	--with-rsyncd-conf=/ffp/etc/rsyncd.conf

make
make DESTDIR=$D install

_doc COPYING INSTALL NEWS README TODO

mkdir -p $D/ffp/etc/
install -m 0644 $X/rsyncd.conf $D/ffp/etc/

mkdir -p $D/ffp/start
install -m 0644 $X/start-rsyncd.sh $D/ffp/start/rsyncd.sh

_descr
_makepkg

