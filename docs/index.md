# The BZDev Debian Repository

The BZDev Debian repository contains a small number of Debian packages
and is intended for use until these are available elsewhere. This
repository is set up to support a large number of architectures:
i385, amd64, Armel, armhf, arm64, mipsel, mips64el, ppc64el, and  s390x
because the packages are not system dependent.

There is a "one liner" for activating this repository:

```
wget -q -O - https://billzaumen.github.io/bzdev/setup.sh | sh
```

This will create two files in subdirectories of `/etc/apt/`.

  - `/etc/apt/sources.list.d/org.bzdev.BZDev.list`
  - `/etc/apt/trusted.gpg.d/org.bzdev.BZDev.gpg`

For those not comfortable running code they have not inspected, the
individual steps (there are only a few) are provided below, and each
can be run separately.

## Setting up apt so that it can use HTTPS

GitHub's web servers always use HTTPS.  To ensure that `apt` can handle
this protocol for older versions of apt, run the command

```
apt-get install apt-transport-https
```

This should not be necessary after apt version 1.5: recent versions of apt
provide HTTPS support by default.

## Configuring apt so it can use the BZDev Debian repository.

If the "one liner" was not used, the repository can be enabled by
executing the following steps.  These steps should be performed in an
empty directory.

First run the command

```
wget -q -O BZDev.gpg https://billzaumen.github.io/bzdev/BZDev.gpg
```

to copy the GPG key used to sign files in the archive.  To verify that
the correct key was downloaded, one can run

```
gpg --show-keys BZDev.gpg
```

If this command prints a line containing

```
91799F893F8E808A63CD120E30B5F51AF1D71940
```

the correct key was downloaded.  To continue, run the command

```
sudo cp BZDev.gpg /etc/apt/trusted.gpg.d/org.bzdev.BZDev.gpg
```

to install the key. Many web pages suggest using apt-key instead, but
that program is being deprecated.

Next, run the command

```
echo deb https://billzaumen.github.io/bzdev/archive/ hirsute contrib  > s.list
echo deb https://billzaumen.github.io/bzdev/archive/ impish contrib  > s.list
```

and then

```
sudo cp s.list /etc/apt/sources.list.d/org.bzdev.BZDev.list
```

Finally,  run the command

```
sudo apt update
```

At this point, the archive will be available for use by `apt` (and other
package managers for Debian repositories).
