_unpack $P
cd ${P%.*}

patch -p1 -i $X/patches/expect-5.43.0-config_update-1.patch
patch -p1 -i $X/patches/expect-5.43.0-spawn-2.patch
patch -p1 -i $X/patches/expect-5.43.0-tcl_8.5.5_fix-1.patch

# look for programs in /ffp/bin
sed -i 's:/usr/local/bin:/ffp/bin:' configure

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--with-tcl=/ffp/lib \
	--with-tclinclude=/ffp/include \
	--with-x=no \
	--mandir=$mandir --infodir=$infodir
    

# fix Makefile, remove unwanted rpath entries
sed -i \
        -e '/^EXP_AND_TCL_LIBS/ s@-Wl,-rpath[^ ]*@@' \
        -e '/^EXP_AND_TK_LIBS/  s@-Wl,-rpath[^ ]*@@' \
        Makefile
    
make
make INSTALL_ROOT=$D install
    
_doc FAQ HISTORY INSTALL NEWS README
_descr
_makepkg

