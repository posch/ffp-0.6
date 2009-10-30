PSMISC_EXTRA_CONFIG=

case "$FFP_ARCH" in
	arm)
		PSMISC_EXTRA_CONFIG="$PSMISC_EXTRA_CONFIG --disable-ipv6"
		;;
esac

_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--exec-prefix="" \
	$PSMISC_EXTRA_CONFIG

make
make DESTDIR=$D install

# psmisc prefers to install to /bin, fix it
mkdir -p $D/ffp
mv $D/bin $D/ffp

ln -s killall $D/ffp/bin/pidof

_doc AUTHORS COPYING ChangeLog INSTALL NEWS README
_descr
_makepkg

