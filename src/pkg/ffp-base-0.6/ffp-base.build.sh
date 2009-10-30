mkdir -p $D/ffp
cd $D/ffp

mkdir -p etc bin sbin start

echo 0.6 >etc/ffp-version

mkdir -p etc/profile.d
install -m 0644 $X/profile $D/ffp/etc

_descr
_makepkg

