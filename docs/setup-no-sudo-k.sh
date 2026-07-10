#/bin/sh
# This version is the same as setup.sh but without
# the use of sudo -k, and is intended for use in
# scripts. As with setup, this should be fetched
# using curl and then piped to sh.

( echo jammy hirsute impish | grep `lsb_release -c -s` ) > /dev/null || \
    ( echo UNSUPPORTED OS RELEASE ; exit 1 ) || exit 1

tmp=bzdev$$.tmp
mkdir $tmp
cd $tmp
trap '' INT QUIT
( wget -q -O BZDev.gpg https://billzaumen.github.io/bzdev/BZDev.gpg && \
  sudo cp BZDev.gpg /etc/apt/trusted.gpg.d/org.bzdev.BZDev.gpg && \
  echo deb https://billzaumen.github.io/bzdev/archive/ `lsb_release -c -s` \
	contrib > s.list && \
  sudo cp s.list /etc/apt/sources.list.d/org.bzdev.BZDev.list && \
  sudo apt update && echo OK ) || echo FAILED
rm -f BZDev.gpg
rm -f s.list
cd ..
[ -d $tmp ] && rmdir $tmp
