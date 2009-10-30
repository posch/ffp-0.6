_unpack $P
cd $P

for p in $X/patches/$P*.patch.gz; do
	zcat $p | patch -p1
done
patch -p1 -i $X/ncurses-5.7-bash_fix-1.patch
patch -p1 -i $X/ncurses-5.7-wctype.patch

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--infodir=$infodir --mandir=$mandir \
	--disable-nls \
	--enable-widec \
	--with-shared \
	--without-debug \
	--without-ada

make
make DESTDIR=$D install

_doc ANNOUNCE INSTALL MANIFEST NEWS README README.emx TO-DO

# http://www.linuxfromscratch.org/lfs/view/development/chapter06/ncurses.html
cd $D/ffp/lib
for lib in curses ncurses form panel menu; do
	echo "INPUT(-l${lib}w)" >lib${lib}.so
	ln -s lib${lib}w.a lib${lib}.a
done
ln -s libncurses++w.a libncurses++.a || true

echo "INPUT(-lncursesw)" >libcursesw.so
ln -sf libncurses.so libcurses.so
ln -sf libncursesw.a libcursesw.a
ln -sf libncurses.a  libcurses.a
    
cd $D/ffp/include
ln -s ncursesw/curses.h .
ln -s ncursesw/ncurses.h .
ln -s ncursesw/term.h

_descr
_makepkg

