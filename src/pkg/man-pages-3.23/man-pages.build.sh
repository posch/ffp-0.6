_unpack $P
cd $P
make DESTDIR=$D MANDIR=$mandir prefix=/ffp install
_makepkg
