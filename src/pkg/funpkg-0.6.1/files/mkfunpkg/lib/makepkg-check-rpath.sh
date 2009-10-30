if which file >/dev/null; then
    find -type f ! -name ld-\*.so | while read f; do
        if file $f | egrep 'ELF.*(executable|shared object)'  >/dev/null; then
            if ! _rpath=$(readelf -d $f | grep RPATH); then
                _warn "$f: No RPATH"
                continue
            fi
            if ! echo "$_rpath" | egrep "[:[]$FFP_RPATH[]:]" >/dev/null; then
                _warn "$f: RPATH does not contain $FFP_RPATH: $_rpath"
            fi
            if echo "$_rpath" | grep "$WORKDIR" >/dev/null; then
                _warn "$f: RPATH contains WORKDIR: $_rpath"
            fi
        fi
    done
fi

