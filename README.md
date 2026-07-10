# bzdev

The bzdev git repository contains a Debian repository
for the BZDev class library and some related programs,
plus instructions for configuring `apt.

Please see <https://billzaumen.github.io/bzdev/> for
step-by-step instructions for using the Debian respository
whose URL is https://billzaumen.github.io/bzdev/archive
This repository contains a small number of Debian packages.

The archive is located under the `docs/` directory. This is
necessary because of GitHub constraints.

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
needs. The Architectures entry for `https://billzaumen.github.io/bzdev/archive`
is quite long because Java runs on a wide variety of systems:

```
i386 amd64 Armel armhf arm64 mipsel mips64el ppc64el s390x
```

Finally, a file named `debs.list` has to be created. This should
not be added to git as the file is a list  the Debian
package files that will be included. The debs.list can contain
relative path names. Relative path names assume that the current
working directory is this git directory.

## Updating the Debian package repository.

To add more classes, one can modify debs.list and run

```
make
git status
git add  [any new files, particularly in docs/archive/pool]
git commit -a
git push
```

With the sequence above, any Debian packages previously added but
not currently in `debs.list` will remain in the repository.

To eliminate Debian packages not in `debs.list`, use

```
make rebuild
git status
git add  [any new files, particularly in docs/archive/pool]
git commit -a
git push
```

While it should be obvious, naturally everything should be checked
before using `git commit` and particularly `git push`.

## Forking

You can copy this git repository to create and manage a different
Debian repository. If that is done, you should edit `README.md`
and `docs/index.md` so that `https://billzaumen.github.io/bzdev/` is
replaced with the appropriate URL.  Similarly the file `docs/BZDev.gpg`
should be renamed and changed to contain the proper public key: it
was created by running

```
gpg --export KEYID > docs/BZDev.gpg
```
and a different name is appropriate.  Similarly  in `docs/index.md`,
BZDev.gpg and org.bzdev should be changed to something else.

Finally, the strings `hirsute` and `contrib` should be changed in
`docs/index.md` to whatever values are appropriate (one names a
Debian/Unbuntu release and the other names a repository component).
Note that multiple components are allowed.
