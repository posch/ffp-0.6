_unpack $P
cd $P
#patch -p1 -i $X/man-1.6e-index_rindex.patch

# First, a sed substitution is needed to modify configure's
# default search path for executables. It cycles through the
# values in PREPATH until it finds the program it is looking
# for. The -R switch is also added to the PAGER variable so that
# escape sequences are properly handled by Less:
sed -i \
	-e "/PREPATH=/s@=.*@=\"$(eval echo /ffp/{bin,sbin})\"@g" \
	-e 's@-is@&R@g' \
	configure

# Another couple of sed substitutions comment out the MANPATH
# /usr/man and MANPATH /usr/local/man lines in the man.conf file
# to prevent redundant results when using programs such as whatis:
sed -i \
	-e 's@MANPATH./usr/man@#&@g' \
	-e 's@MANPATH./usr/local/man@#&@g' \
	src/man.conf.in

# won't ever use X11 on the dns323
sed -i \
	-e "/^MANPATH/ s,/usr/X11R6/.*,$mandir," \
	src/man.conf.in

# fix bindir in man2html
sed -i 's@/usr/@/ffp/@' man2html/Makefile.in

export LDFLAGS="$FFP_LDFLAGS"
./configure \
	-prefix=/ffp \
	-confdir=/ffp/etc \
	-mandir=$mandir \
	+lang none
    
make
make DESTDIR=$D install
    
_doc COPYING INSTALL LSM README TODO
_descr
_makepkg

