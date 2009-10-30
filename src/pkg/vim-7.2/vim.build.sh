_unpack $P
cd vim72

for p in $X/patches/7.2.???.gz; do
	echo "patch: $p"
	zcat $p | patch -p0
done || true

echo '#define SYS_VIMRC_FILE "/ffp/etc/vimrc"' >> src/feature.h

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--enable-multibyte \
	--without-x \
	--disable-gui \
	--with-features=huge

make
make DESTDIR=$D install

# create a default config file
mkdir -p $D/ffp/etc
cat >$D/ffp/etc/vimrc <<EOF
" Begin /etc/vimrc

set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
	set background=dark
endif
set number
set title

" End /etc/vimrc
EOF

_doc README.txt
_descr
_makepkg

