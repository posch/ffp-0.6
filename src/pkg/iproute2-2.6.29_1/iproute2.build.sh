set -e

S=$(echo $P | tr '_' '-')
_unpack $S
cd $S

# no IPv6 on arm oabi
if [ "$FFP_ARCH" == "arm" ]; then
	patch -p1 -i $X/iproute2-no_inet6.patch
fi

# don't build arpd (requires berkeley db)
sed -i.orig '/^TARGETS/s@arpd@@g' misc/Makefile

# fix paths
sed -i.orig \
	-e '/^SBINDIR/ s@=.*@=/ffp/sbin@' \
	-e '/^CONFDIR/ s@=/etc@=/ffp/etc@' \
	-e "/^DOCDIR/ s@=.*@=$docdir/$P@" \
	-e "/^MANDIR/ s@=/share@=$mandir@" \
	-e 's,/usr/,/ffp/,g' \
	Makefile
	
# fix libdir in tc/
sed -i.orig 's@/lib/tc@/ffp&@' \
	tc/Makefile \
	netem/Makefile

# fix /usr/local/ in include/iptables.h
sed -i.orig 's@/usr/local/@/ffp/@' include/iptables.h

make LDFLAGS="$FFP_LDFLAGS"
make DESTDIR=$D install

_doc COPYING README* RELNOTES
_descr
_makepkg

