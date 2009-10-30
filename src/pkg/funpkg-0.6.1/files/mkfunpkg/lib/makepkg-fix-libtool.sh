find . -type f -name \*.la | while read f; do
    # remove all -L$W blocks
    sed -i "/^dependency_libs=/ s@ -L$W[^' ]*@@g" $f
done
