if [ -d .$mandir ]; then
    for f in $(find .$mandir/man* -type f -a ! -name "*.gz"); do
	if [ -e "$f" ]; then
	    #_print "gzip $f"
	    gzip -9c "$f" >"$f.gz"
	    for g in $(find .$mandir/man* -type f -samefile "$f" \! -path "$f" \! -name "*.gz"); do
		#_print "ln $f.gz $g.gz"
		ln "$f.gz" "$g.gz"
		rm "$g"
	    done
	    rm "$f"
	fi
    done
    for f in $(find .$mandir/man* -type l -a ! -name "*.gz"); do
	g=$(readlink "$f")
	#_print "ln -s $g.gz $f.gz"
	ln -s "$g.gz" "$f.gz"
	rm "$f"
    done
fi

