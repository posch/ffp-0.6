_unpack $P
cd $P

# perl has a lot of hardcoded /usr paths. Sedding them all
# might be solution. Linking /usr -> /ffp might be another
# solution. For now, we prefer linking /usr -> /ffp, as
# it's safe to do in qemu.
if [ "$(readlink -f /usr)" != "/ffp" ]; then
	die "WARNING: Need /usr -> /ffp link"
fi

# The cross-lfs people only change the path in Errno_pm.PL
sed -i 's@/usr/include@/ffp/include@g' ext/Errno/Errno_pm.PL

if [ ! -e /etc/hosts ]; then
	echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
fi

patch -p1 -i $X/patches/perl-5.10.1-libc-1.patch
patch -p1 -i $X/patches/perl-5.8.8-linux-libc_so_0.patch
#sed -i "/linux/ s@-shared@& ${FFP_LDFLAGS}@" Configure

# Disable -fstack-protector
sed -i 's,set stack-protector .*,,g' Configure 
#sed -i '/dflt/ s, -fstack-protector,,g' Configure 
#sed -i '/flags/ s, -fstack-protector,,g' Porting/config.sh

# provide a fake uname program
mkdir -p $W/bin
install -m 0755 $X/fake-uname.sh $W/bin/uname
install -m 0755 $X/fake-arch.sh  $W/bin/arch
export PATH=$W/bin:$PATH

./configure.gnu \
	--prefix=/ffp \
	-Dvendorprefix=/ffp \
	-Dman1dir=$mandir/man1 \
	-Dman3dir=$mandir/man3 \
	-Dpager="/ffp/bin/less -isR" \
	-Dusethreads \
	-Dcc=gcc \
	-Dldflags="$FFP_LDFLAGS" \
	-Dlddlflags="-shared -O2 $FFP_LDFLAGS" \
	-Dccdlflags="-Wl,-E $FFP_LDFLAGS"

yes '' | make
make DESTDIR=$D install
    
_doc AUTHORS Artistic INSTALL README MANIFEST
_descr
_makepkg

