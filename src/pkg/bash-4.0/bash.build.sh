set -e
_unpack $P
cd $P
for f in $X/patches/bash40-*.gz; do
	echo "patch $f"
	zcat $f | patch -p0
done
    
#  /ffp/etc/profile
sed -i "/SYS_PROFILE/ s,/etc/,/ffp&," pathnames.h.in

#  /ffp/etc/inputrc
sed -i "/SYS_INPUTRC/ s,/etc/,/ffp&," lib/readline/rlconf.h

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_HOST --host=$GNU_TARGET \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls \
	--without-bash-malloc \
	--with-installed-readline

make
make DESTDIR=$D install

_doc ABOUT-NLS COPYING NEWS NOTES POSIX README AUTHORS
_descr
_makepkg

