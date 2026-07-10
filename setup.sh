#!/bin/sh

echo This will change git\'s configuration.
echo
echo You will be asked for the following values:
echo Origin: something like foo.gethub.io
echo Label: something like apt repository
echo Codename: something like hirute "(name of a Debian/Ununtu distribution)"
echo Architectures: typically i386 amd64
echo Components: something like contrib
echo Description: something like BZDev packages
echo SignWith: the fingerprint of the GPG key used for signing
echo
echo Type some text, or just RETURN, to continue, ^C to exit.

read -p "Continue? " REPLY && echo OK

for i in Origin Label Codename Architectures Components Description SignWith
do
    git config --local distributions.$i "`read -p $i': ' REPLY ; echo $REPLY`"
done
