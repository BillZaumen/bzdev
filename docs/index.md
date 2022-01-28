# The BZDev Debian Repository

The BZDev Debian repository contains a small number of Debian packages
and is intended for use until these are available elsewhere. This
repository is set up to support a large number of architectures:
i385, amd64, Armel, armhf, arm64, mipsel, mips64el, ppc64el, and  s390x
because the packages are not system dependent.

There is a "one liner" for activating this repository:

```
curl https://billzaumen.github.io/bzdev/setup.sh | sh
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
curl -s -o BZDev.gpg https://billzaumen.github.io/bzdev/BZDev.gpg
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

At this point, the archive will be available for use by `apt` (and
other package managers for Debian repositories).  The archive provides
several Debian packages, listed below.

## Debian packages for the BZDev class library

    - libbzdev-java (the Debian package with dependencies on 
      the following 13 packages)

        - libbzdev-anim2d-java (the Debian package for the module
	  org.bzdev.anim2d)

        - libbzdev-base-java (the Debian package for the module
	  org.bzdev.base)

        - libbzdev-desktop-java (the Debian package for the module
          org.bzdev.desktop)

        - libbzdev-devqsim-java (the Debian package for the module
	  org.bzdev.devqsim)

        - libbzdev-dmethods-java (the Debian package for the module
	  org.bzdev.dmethods)

        - libbzdev-drama-java (the Debian package for the module
	  org.bzdev.drama)

        - libbzdev-ejws-java (the Debian package for the module
	  org.bzdev.ejws)

        - libbzdev-esp-java (the Debian package for the module
	  org.bzdev.esp)

        - libbzdev-graphics-java (the Debian package for the module
	  org.bzdev.graphics)

        - libbzdev-math-java (the Debian package for the module
	  org.bzdev.math)

        - libbzdev-obnaming-java (the Debian package for the module
	  org.bzdev.obnaming)

        - libbzdev-parmproc-java (the Debian package for the module
	  org.bzdev.parmproc)

        - libbzdev-p3d-java (the Debian package for the module
          org.bzdev.p3d)

    - libbzdev-util (the Debian package containing the programs
      lsnof, scrunner, and yrunner)

    - libbzdev-misc (the Debian package providing icons for files
      of various types and their media/MIME types)

    - libbzdev-doc  (pending)

    - libbzdev-darkmode-doc (pending)

    - libbzdev-pop-icons (the Debian package setting up icons for
      Pop!_OS)

## Debian packages for supplemental libraries

    - libbikeshare-darkmode-doc

    - libbikeshare-doc

    - libbikeshare-java

    - libosgbatik-java (the Debian package for a service provider
      for SVG graphics, based on the Apache Batik project)

    - librdanim-darkmode-doc (the Debian package with documentation for
      librdanim-java usig a dark-mode style)

    - librdanim-doc  (the Debian package with documentation for
      librdanim-java using the default style)

    - librdanim-java (the Debian package with classes that define
      objects used by the libbzdev-anim2d-java package)

## Debian packages for programs and miscellaneous files 

    - bzdev-wallpapers

    - cvrdecode

    - epts

    - evdisk

    - geth

    - webnail

# Other Package Managers

For other package managers, the program alien can convert debian packages
to other package-manager formats.  As a warning, one should hand-check
any scripts (these merely set up symbolic links and call programs to
update icons and media types, which would otherwise require rebooting).

Please visit [Debian Package URLS] (https://billzaumen.github.io/bzdev/debian-urls.html)
for a list of URLs for the relevant Debian packages.

# Installers

Installers for other systems are available as JAR files. Please
visit [Installer JAR Files](https://billzaumen.gethub.io/bzdev/installers.html)
for a list of commands (using curl) that will download these JAR
files and store them in the current working directory.
