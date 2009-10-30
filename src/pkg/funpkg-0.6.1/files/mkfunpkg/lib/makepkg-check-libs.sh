# check for broken libs
find . -type f -name \*.so\* | while read f; do
    # check for non-PIC libs
    if readelf -a $f | grep R_ARM_PC24 >/dev/null 2>&1; then
        _warn "$f: Found R_ARM_PC24"
    fi
done
