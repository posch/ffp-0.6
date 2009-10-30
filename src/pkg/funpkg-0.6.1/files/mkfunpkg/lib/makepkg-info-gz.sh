if [ -d .$infodir ]; then
    rm -f .$infodir/dir;
    for f in $(find .$infodir -type f ! -name "*.gz"); do
	#_print "gzip $f"
	gzip -9 "$f"
    done
fi



