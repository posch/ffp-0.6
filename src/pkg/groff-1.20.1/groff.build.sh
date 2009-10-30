_unpack $P
cd $P

LDFLAGS="$FFP_LDFLAGS" \
PAGE=A4 \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--docdir=$docdir/$P
    
make
    
mkdir -p $D/ffp
make prefix=$D/ffp install
    
_doc BUG-REPORT COPYING FDL INSTALL INSTALL.gen MORE.STUFF NEWS PROBLEMS \
	PROJECTS README TODO VERSION

cd $D/ffp/bin
ln -s eqn geqn
ln -s tbl gtbl

_descr
_makepkg

