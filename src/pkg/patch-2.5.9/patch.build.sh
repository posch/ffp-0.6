_unpack $P
cd $P

#update_gnu_config

patch -p1 -i $X/patches/patch-2.5.9-fixes-1.patch

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls
    
make
make prefix=$D/ffp install
    
_doc AUTHORS COPYING NEWS README
_descr
_makepkg

