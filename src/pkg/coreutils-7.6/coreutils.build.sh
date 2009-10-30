set -e
_unpack $P
cd $P

patch -p1 -i $X/coreutils-7.6-uname-1.patch

# setting DEFAULT_POSIX2_VERSION as below allows tail -20 etc

LDFLAGS="$FFP_LDFLAGS" \
DEFAULT_POSIX2_VERSION=199209 \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--enable-install-program=hostname

make
make DESTDIR=$D install

# dircolors
mkdir -p $D/ffp/etc/profile.d
install -m 0755 $X/coreutils-dircolors.sh $D/ffp/etc/profile.d/

_doc ABOUT-NLS AUTHORS COPYING NEWS README THANKS THANKS-to-translators TODO
_descr
_makepkg

