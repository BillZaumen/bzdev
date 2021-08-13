# bzdev

The bzdev git repository contains a Debian repository
for the BZDev class library and some related programs,
plus instructions for configuring `apt.

Please see <https://billzaumen.github.io/bzdev/> for
step-by-step instructions for using the Debian respository
whose URL is https://billzaumen.github.io/bzdev/archive
This repository contains a small number of Debian packages.

## Building the Debian package repository

You will need to install the Debian package reprepro, which is
used to build Debian repositories:

```
sudo atp-get install reprepro
```

After cloning this git repository, type the command

```
./setup.sh
```

This will configure git.  The values it sets are describe in
<http://blog.jonliv.es/blog/2011/04/26/creating-your-own-signed-apt-repository-and-debian-packages/>
and are ultimately used to create a conf/distributions file. The shell
script `./setup.sh` is interactive and will prompt the user for the
required fields that conf/distributions  (used by `reprepro`)
needs.

Finally, a file named `debs.list` has to be created. This should
not be added to git as the file is a list  the Debian
package files that will be included. The debs.list can contain
relative path names. Relative path names assume that the current
working directory is this git directory.


