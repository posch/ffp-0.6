#!/ffp/bin/sh
o=$(/ffp/bin/uname -m)
n=arm
/ffp/bin/uname "$@" | sed "s,$o,$n,g"

