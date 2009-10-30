set -e

# funpkg
_unpack $P
cd $P
sed -i "/^LDFLAGS/ s@=@= $FFP_LDFLAGS@" Makefile
make CFLAGS="$FFP_CFLAGS"
mkdir -p $D/ffp/bin
install -m 0755 funpkg $D/ffp/bin
mkdir -p $D/ffp/funpkg/installed
mkdir -p $D/ffp/funpkg/removed

# funpkg config
cd $X/files/funpkg
mkdir -p $D/ffp/etc/funpkg
echo $FFP_ARCH >$D/ffp/etc/ffp-arch
install -m 0644 dist.rules $D/ffp/etc/funpkg

# slacker
cd $X/files/slacker
install -m 0755 slacker newconf $D/ffp/bin
mkdir -p $D/ffp/etc/slacker
sed "s,\$FFP_ARCH,$FFP_ARCH,g" sites_template >$D/ffp/etc/slacker/sites

# mkfunpkg
cd $X/files/mkfunpkg
mkdir -p $D/ffp/src $D/ffp/lib/mkfunpkg
cp -a lib/* $D/ffp/lib/mkfunpkg/
mkdir -p $D/ffp/sbin
install -m 0755 mkfunpkg $D/ffp/sbin

_descr
_makepkg tgz

