set -e
_unpack $P
cd $P

make
make DESTDIR=$D PREFIX=/ffp install

_doc COPYING CREDITS NEWS README VERSION
_descr 
_makepkg

