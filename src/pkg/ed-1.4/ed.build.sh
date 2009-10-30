_unpack $P
cd $P

./configure \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	LDFLAGS="$FFP_LDFLAGS"

make
make DESTDIR=$D install
    
_doc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
_descr
_makepkg tgz

