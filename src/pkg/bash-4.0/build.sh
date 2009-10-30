unpack bash-$PV
cd bash-$PV

patch -p0 -i ../bash40-001
patch -p0 -i ../bash40-002
patch -p0 -i ../bash40-003
patch -p0 -i ../bash40-004
patch -p0 -i ../bash40-005
patch -p0 -i ../bash40-006
patch -p0 -i ../bash40-007
patch -p0 -i ../bash40-008
patch -p0 -i ../bash40-009
patch -p0 -i ../bash40-010
patch -p0 -i ../bash40-011
patch -p0 -i ../bash40-012
patch -p0 -i ../bash40-013
patch -p0 -i ../bash40-014
patch -p0 -i ../bash40-015
patch -p0 -i ../bash40-016
patch -p0 -i ../bash40-017
patch -p0 -i ../bash40-018
patch -p0 -i ../bash40-019
patch -p0 -i ../bash40-020
patch -p0 -i ../bash40-021
patch -p0 -i ../bash40-022
patch -p0 -i ../bash40-023
patch -p0 -i ../bash40-024

#  /ffp/etc/profile
sed -i "/SYS_PROFILE/ s,/etc/,/ffp&," pathnames.h.in

#  /ffp/etc/inputrc
sed -i "/SYS_INPUTRC/ s,/etc/,/ffp&," lib/readline/rlconf.h

CFLAGS="$FFP_CFLAGS" \
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_HOST --host=$GNU_TARGET \
	--prefix=/ffp \
	--mandir=/ffp/share/man \
       	--infodir=/ffp/share/info \
	--disable-nls \
	--without-bash-malloc \
	--with-installed-readline

make
make DESTDIR=$D install

mkdir -p $D/ffp/share/doc/$P
cp ABOUT-NLS COPYING NEWS NOTES POSIX README AUTHORS \
	$D/ffp/share/doc/$P

mkdir -p $D/install
cp $X/DESCR $D/install

makepkg

