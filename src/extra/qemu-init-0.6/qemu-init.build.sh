mkdir -p $D
cd $D


mkdir -p dev etc home proc root sys tmp
chmod 01777 tmp

mkdir -p ffp ffp/bin ffp/sbin
ln -s ffp/bin bin
ln -s ffp/sbin sbin
ln -s ffp usr


cd $X/files
install -m 0644 fstab group hosts inittab passwd $D/etc
install -m 0755 rc.sysinit $D/etc
ln -s /proc/mounts $D/etc/mtab

cd $D/dev
ln -snf /proc/kcore     core
ln -snf /proc/self/fd   fd
ln -snf /proc/self/fd/0 stdin
ln -snf /proc/self/fd/1 stdout
ln -snf /proc/self/fd/2 stderr
mknod null    c 1 3
mknod console c 5 1
mknod ttyAMA0 c 204 16

_descr
_makepkg tgz

