
_unpack $P
cd $P

# need GNU patch, fails with busybox patch
patch -p1 -i $X/zlib-1.2.3-fPIC-1.patch

sed -i "/Linux.* LDSHARED=/ s@ -shared @&${FFP_LDFLAGS} @" configure

AR="ar rc" \
    ./configure \
    --prefix=/ffp \
    --shared

make
make prefix=$D/ffp mandir=$D$mandir install
chmod 0644 $D/ffp/lib/libz.a

_doc ChangeLog FAQ INDEX README
_descr
_makepkg

