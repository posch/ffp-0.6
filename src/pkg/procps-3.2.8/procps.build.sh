set -e
_unpack $P
cd $P

patch -p1 -i $X/procps-3.2.7-ffp.diff
#patch -p1 -i $X/procps-3.2.7-ice.diff

sed -i "s,/\(ffp\|usr\)/share/man,$mandir," Makefile

#make CFLAGS="-O1"

make LDFLAGS="$FFP_LDFLAGS"
make DESTDIR=$D ldconfig=: install

_doc BUGS COPYING* NEWS TODO
_descr
_makepkg

