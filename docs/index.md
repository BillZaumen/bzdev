# The BZDev Debian Repository

The BZDev Debian repository contains a small number of Debian packages
and is intended for use until these are available elsewhere. This
repository is set up to support a large number of architectures:
i385, amd64, Armel, armhf, arm64, mipsel, mips64el, ppc64el, and  s390x
because the packages are not system dependent.

## Setting up apt so that it can use HTTPS

GitHub's web servers always use https.  To ensure that `apt` can handle
this protocol for older versions of apt, run the command

```
apt-get install apt-transport-https
```

This is not necessary after apt version 1.5: recent versions of apt
provide HTTPS support by default (at least that is what the documentation
claims).

## Configuring apt so it can use the BZDev Debian repository.

There are three steps:

First run the command

```
sudo wget -O BZDev.gpg https://billzaumen.github.io/bzdev/BZDev.gpg
```

to copy the GPG key used to sign files in the archive.  To verify that
the correct key was downloaded, run

```
gpg --show-keys BZDev.gpg
```

If this command prints a line containing

```
91799F893F8E808A63CD120E30B5F51AF1D71940
```

it is safe to continue by running the command

```
sudo cp BZDev.gpg /etc/apt/trusted.gpg.d/org.bzdev.BZDev.gpg
```

to install the key. Many web pages suggest using apt-key instead.
That program is being deprecated.

Second, run the command

```
sudo echo deb https://billzaumen.github.io/bzdev/archive/ \
hirsute contrib  > /etc/apt/sources.list.d/org.bzdev.BZDev.list
```

Finally run the command

```
sudo apt update
```

At this point, the archive will be available for use by `apt` (and other
package managers).


