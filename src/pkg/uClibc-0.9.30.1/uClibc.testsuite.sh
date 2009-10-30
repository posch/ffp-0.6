cd uClibc-$PV
export TIMEOUTFACTOR=15
make -k check UCLIBC_ONLY=1 V=1
