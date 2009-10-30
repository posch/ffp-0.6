_unpack linux-$PV
cd linux-$PV

make ARCH=$LINUX_ARCH INSTALL_HDR_PATH=$D/ffp headers_install

# include/scsi.* is broken, use uClibc version
rm -rf $D/ffp/include/scsi

_descr
_makepkg

