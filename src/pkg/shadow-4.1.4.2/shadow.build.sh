_unpack $P
cd $P

# use /ffp/etc/login.defs
sed -i 's,"/etc/login.defs","/ffp/etc/login.defs",' lib/getdef.c

# use /ffp/etc/shells
sed -i 's,"/etc/shells","/ffp/etc/shells",' src/chsh.c

# use /ffp/etc/login.access
sed -i 's,"/etc/login.access","/ffp/etc/login.access",' src/login_nopam.c

# use /ffp/etc/suauth
sed -i 's,"/etc/suauth","/ffp/etc/suauth",' src/suauth.c

# use /ffp/etc/skel, and /ffp/etc/default/*
sed -i  -e 's,"/etc/skel","/ffp/etc/skel",' \
	-e 's,"/etc/default/,"/ffp/etc/default,' \
	src/useradd.c

# use /ffp/etc/logoutd.mesg
sed -i 's,"/etc/logoutd.mesg","/ffp/etc/logoutd.mesg",' src/logoutd.c


# adjust paths in etc/defaults/useradd
sed -i  -e '/^SHELL=/ s,=.*,=/ffp/bin/sh,' \
	-e '/^SKEL=/  s,=.*,=/ffp/etc/skel,' \
	etc/useradd

# adds support for
# --without-nscd
#patch -p1 -i $X/shadow-4.1.2.1-uclibc.diff

sed -i \
        -e "/MOTD_FILE/      s@/etc/@/ffp&@" \
        -e "/ISSUE_FILE/     s@/etc/@/ffp&@" \
        -e "/TTYTYPE_FILE/   s@/etc/@/ffp&@" \
        -e "/HUSHLOGIN_FILE/ s@/etc/@/ffp&@" \
        -e "/ENV_SUPATH/     s@=@=/ffp/sbin:/ffp/bin:@" \
        -e "/ENV_PATH/       s@=@=/ffp/bin:@" \
        -e "/ENVIRON_FILE/   s@/etc/@/ffp&@" \
        -e "/USERDEL_CMD/    s@/usr/@/ffp/@" \
        etc/login.defs

sed -i \
        -e "s@^CONSOLE@# &@" \
        -e "s@^CRACKLIB_DICTPATH@# &@" \
        etc/login.defs

sed -i \
	-e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD MD5@' \
	-e 's@/var/spool/mail@/ffp/var/mail@' \
	etc/login.defs

LDFLAGS="$FFP_LDFLAGS" \
./configure \
	--build=$GNU_BUILD --host=$GNU_HOST \
	--prefix=/ffp \
	--mandir=$mandir --infodir=$infodir \
	--disable-nls \
	--without-nscd \
	--without-libpam

make
make DESTDIR=$D install

_doc COPYING NEWS README TODO doc/HOWTO doc/README.limits
_descr
_makepkg

