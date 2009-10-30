unpack $P
cd $P

# remove hard-coded /usr/include from Makefile
sed -i "s/-I@includedir@//g" Makefile.in

if [ "$GNU_BUILD" != "$GNU_HOST" ]; then
	echo 'ac_cv_func_malloc_0_nonnull=yes' >>config.cache
	echo 'ac_cv_func_realloc_0_nonnull=yes' >>config.cache
	CC="$GNU_TARGET-gcc -fPIC"
else
	CC="gcc -fPIC"
fi

CFLAGS="$FFP_CFLAGS" \
LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--cache-file=config.cache

make CC="$CC" libfl.a
make
make DESTDIR=$D install

install_doc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README* THANKS TODO

