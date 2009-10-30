d=$(ls -1 | egrep -v '^(ffp|install)$')
if [ -n "$d" ]; then
    _warn "Found extra directories in package: $d"
fi

if [ -d ffp/share/man ]; then
	_warn "Found ffp/share/man"
fi

if [ -d ffp/share/info ]; then
	_warn "Found ffp/share/info"
fi

