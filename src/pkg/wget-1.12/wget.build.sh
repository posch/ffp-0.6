_unpack $P
cd $P

# fix hard-coded /usr/ paths
sed -i 's,/usr/,/ffp/,g' \
	doc/texi2pod.pl \
	tests/*.p* \
	util/*.pl

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--sysconfdir=/ffp/etc \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls

make
make DESTDIR=$D install

_doc AUTHORS COPYING MAILING-LIST NEWS README
_descr
_makepkg

