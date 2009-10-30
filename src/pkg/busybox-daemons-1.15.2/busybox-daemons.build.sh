_unpack busybox-$PV
cd busybox-$PV

# fix hardcoded perl interpreter path
sed -i 's,/usr/bin/perl,/ffp/bin/perl,' */*.pl

# adjust config
cat $X/$PN.config >.config

config_set() {
    sed -i "s,^$1=.*,$1=\"$2\"," .config
}
config_enable() {
    sed -i "s,^# $1 is not set,$1=y," .config
}
config_disable() {
    sed -i "s,$1=y,# $1 is not set," .config
}

yes '' | make oldconfig
make V=1 LDFLAGS="$FFP_LDFLAGS"

# install and rename busybox binary
sed -i "/bb_path=/ s,busybox\",$P\"," applets/install.sh
make V=1 LDFLAGS="$FFP_LDFLAGS" CONFIG_PREFIX=$D/ffp install
mv $D/ffp/bin/busybox $D/ffp/bin/$P
rm -f $D/ffp/bin/bbconfig

_doc $X/$PN.config AUTHORS INSTALL LICENSE README 
_descr
_makepkg

