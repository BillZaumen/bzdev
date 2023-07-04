# The BZDev Debian Repository

Links to other sections:

  - [Other Package Managers](#other-package-managers). How to convert
    to RPM, etc.

  - [Docker Containers](#docker-containers). Docker containers based on
    this library.

  - [Installers](#installers). Installers for other Unix systems and
    Windows.

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

The script setup.sh uses sudo -k so that a password is always
required. This can be annoying in scripts.  In that case, one
can use

```
curl https://billzaumen.github.io/bzdev/setup-no-sudo-k.sh | sh
```

For either case, the command will fail with an exit status of 1 if
the command

```
lsb_release -c -s
```

does not print either "hirsute", "impish", or "jammy" (the codenames
for the releases currently recognized).

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
echo deb https://billzaumen.github.io/bzdev/archive/ \
   `lsb_release -s -c` contrib  > s.list
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

The packages are the following:

  - libbzdev-java (the Debian package with dependencies on the
    following 13 packages)

      - libbzdev-anim2d-java (the Debian package for the module
	  org.bzdev.anim2d).

      - libbzdev-base-java (the Debian package for the module
	  org.bzdev.base).

      - libbzdev-desktop-java (the Debian package for the module
        org.bzdev.desktop).

      - libbzdev-devqsim-java (the Debian package for the module
	  org.bzdev.devqsim).

      - libbzdev-dmethods-java (the Debian package for the module
	  org.bzdev.dmethods).

      - libbzdev-drama-java (the Debian package for the module
	  org.bzdev.drama).

      - libbzdev-ejws-java (the Debian package for the module
	  org.bzdev.ejws).

      - libbzdev-esp-java (the Debian package for the module
	  org.bzdev.esp).

      - libbzdev-graphics-java (the Debian package for the module
	  org.bzdev.graphics).

      - libbzdev-math-java (the Debian package for the module
	  org.bzdev.math).

      - libbzdev-obnaming-java (the Debian package for the module
	  org.bzdev.obnaming).

      - libbzdev-parmproc-java (the Debian package for the module
	  org.bzdev.parmproc).

      - libbzdev-p3d-java (the Debian package for the module
        org.bzdev.p3d).

  - libbzdev-util (the Debian package containing the programs
    lsnof, sbl, scrunner, and yrunner).

  - libbzdev-misc (the Debian package providing icons for files
    of various types and their media/MIME types).

  - libbzdev-doc (the API Documention using a default style).

  - libbzdev-darkmode-doc (the API documentation using a revere-video,
    high contrast theme for better readibility).

  - libbzdev-pop-icons (the Debian package setting up icons for
    Pop!_OS).

## Debian packages for supplemental libraries

  - libbikeshare-java (A simulation of a bicycle-sharing system,
    useful as an example).

  - libbikeshare-doc (the API documentation for bicycle-sharing
    simulation using the default style).

  - libbikeshare-darkmode-doc (the API documentation for bicycle-sharing
    simulation using a high-contrast, reverse-video theme).

  - libosgbatik-java (the Debian package for a service provider
    for SVG graphics, based on the Apache Batik project). This makes
    svg a recognized image type for writing graphics files using
    the OuputStreamGraphics class provided by the libbzdev-graphics-java
    package.

  - librdanim-java (the Debian package for classes that extend the
    libbzdev-anim2d-java package in order to create animations of
    cars, pedestrians, and bicycles).

  - librdanim-doc  (the Debian package with documentation for
    librdanim-java using the default style).

  - librdanim-darkmode-doc (the Debian package with documentation for
    librdanim-java usig a dark-mode style).

## Debian packages for programs and miscellaneous files 

  - bzdev-wallpapers (Screen backgrounds based on Hilbert's space-filling
    curve).

  - cvrdecode (A program to decode California digital vaccine records and
    create a table giving names, date of birth, and whether or not fully
    vaccinated).

  - emacs-espmode-el (Files for configuring emacs lisp for providing a
    mode for editing ESP files, which either end in the extension
    ".esp" or whose contents start with a number sign, an exclamation
    point, and /usr/bin/scrunner, with no intervening spaces or tabs).

  - epts (A graphics editor for paths that can export files in a variety
    of formats including SVG and the scripting language used by the
    simulation and animation softwre listed above).

      - epts-pop-icons (Icons for EPTS for use with Pop!_OS)

  - evdisk (A simple Linux-based utility that will create an
    encrypted file system using LUKS, accessed via the loopback
    device; the password [32 random printable characters] is
    provided as well but encrypted using GPG).

  - gethdrs (A utility that will print out HTTP headers returned from an
    HTTP request, including those from an HTTP redirect). This was
    previously named geth but an unrelated package is using that name.

  - qrlauncher (A utility that will decode QR codes and automatically
    open an application for viewing the contents, typically be passing
    a file or a URL to a browser).

      - qrlauncher-pop-icons  (Icons for QRLauncher for use with
        Pop!_O.S)

  - webnail (A graphics program that can take multiple image files,
    scale them to fit inside a bounding box, an generate a set of web
    pages that can display the images as a slide show).  Webnail has
    a built-in web server that allows multiple computers to show the
    same images at the same time.

      - webnail-pop-icons (Icons for webnail for use with Pop!_OS.)

      - webnail-server (a simplified webnail package that provides
        a server but cannot create output files or directories - used
	when only the web server needs to be installed.)

  -  libecdb-java  (A library used to implement a service that can
     email calendar appointments.)

       - ecdb-javamail (An ecdb service provider that allows ecdb to use
         javamail; javamail must be downloaded separately.)

       - libecdb-doc (ecdb API documentation using the default style.)

       - libecdb-darkmode-doc (ecdb API documentation using a dark-mode style.)

       - ecdb-desktop (The ecdb desktop files, ecdb command, and man pages.)

       - ecdb-derby (Package to configure the Derby database for use with
         ecdb; the Derby database must be downloaded separately.)

       - ecdb-pop-icons (ecdb icons for Pop!_OS.)

# Other Package Managers

For other package managers, the program alien can convert debian
packages to other package-manager formats.  As a warning, one should
hand-check any scripts (the ones in the Debian packages merely set up
symbolic links and call programs to update icons and media types,
which would otherwise require rebooting).  To use alien, it is
necessary to download the Debian packages, probably without using apt
or apt-get. To help locate these, there is a
[list of package links](https://billzaumen.github.io/bzdev/packages.html).

# Docker Containers

The following Docker containers are available:

  - [wtzbzdev/cvrdecode](https://hub.docker.com/r/wtzbzdev/cvrdecode):
    a container that creates a web server that can process a ZIP
    file containing California digital vaccine records, verify the
    digital signatures, and provide a CSV file with a line for each
    record.

  - [wtzbzdev/epimodel](https://hub.docker.com/r/wtzbzdev/epimodel):
    A container that creates a web server that will run a simple
    epidemiological model and show the output as a graph.

  - [wtzbzdev/webnail](https://hub.docker.com/r/wtzbzdev/webnail):
    A container that creates a web server that can provide web
    pages generated by the webnail program.

# Installers

Installers for other systems are available as JAR files. Please
visit [Installer JAR Files](https://billzaumen.github.io/bzdev/installers.html)
for a list of links for downloading installers. Each installer can be
run using the command

```
java -jar INSTALLER
```

where INSTALLER is a JAR file.
