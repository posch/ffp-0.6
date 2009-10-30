_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir --docdir=$docdir/$P \

make
make DESTDIR=$D install

_doc INSTALL LICENCE META-FAQ README 
_descr
_makepkg

