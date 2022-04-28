#/bin/sh
tmp=bzdev$$.tmp
mkdir $tmp
cd $tmp
trap '' INT QUIT
( wget -q -O BZDev.gpg https://billzaumen.github.io/bzdev/BZDev.gpg && \
  sudo cp BZDev.gpg /etc/apt/trusted.gpg.d/org.bzdev.BZDev.gpg && \
  echo deb https://billzaumen.github.io/bzdev/archive/ hirsute \
	contrib > s.list && \
  echo deb https://billzaumen.github.io/bzdev/archive/ impish \
	contrib >> s.list && \
  echo deb https://billzaumen.github.io/bzdev/archive/ jammy \
	contrib >> s.list && \
  sudo cp s.list /etc/apt/sources.list.d/org.bzdev.BZDev.list && \
  sudo apt update && echo OK ) || echo FAILED
rm -f BZDev.gpg
rm -f s.list
sudo -k
cd ..
[ -d $tmp ] && rmdir $tmp
