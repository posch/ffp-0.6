set -e
_unpack $P
cd $P
    
for p in $X/patches/*.patch; do
	patch -p1 -i $p
done

#patch -p1 -i $X/util-linux-versionsort.patch
    
sed -i 's@etc/adjtime@ffp/var/lib/hwclock/adjtime@g' $(grep -rl '/etc/adjtime' .)
mkdir -pv $D/ffp/var/lib/hwclock
    
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir --docdir=$docdir/$P \
	--disable-nls \
	--enable-arch --enable-partx --enable-write \
	--disable-tls \
	--enable-libuuid --enable-libblkid
    
make
make DESTDIR=$D install
    
_doc ABOUT-NLS AUTHORS COPYING DEPRECATED NEWS README README.devel README.licensing TODO
_descr
_makepkg

