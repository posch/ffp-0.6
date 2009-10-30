for f in $(find -type f | file -f - 2>/dev/null | grep ': *ELF .*executable'    | cut -d: -f1); do
    echo "${STRIP:-strip} --strip-unneeded $f"
    ${STRIP:-strip} --strip-unneeded "$f"
done
for f in $(find -type f | file -f - 2>/dev/null | grep ': *ELF .*shared object' | cut -d: -f1); do
    echo "${STRIP:-strip} --strip-debug $f"
    ${STRIP:-strip} --strip-debug "$f"
done

