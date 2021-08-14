# GNU Makefile

# The user must add a file named debs.list in which each
# line provides a path to a Debian package file. The path
# can be an absolute path or a relative path.
#
# git must also be configured.  The configuration that is used
# for billzaumen.github.io  was set up by running the following:
#
#	git config --local distributions.Origin billzaumen.gethub.io
#       git config --local distributions.Label "apt repository"
#       git config --local distributions.Codename hirsute
#       git config --local distributions.Architectures "i386 amd64 ..."
#       git config --local distributions.Components contrib
#       git config --local distributions.Description "BZDev packages"
#       git config --local distributions.SignWith 91799F893F8E808A63CD120E30B5F51AF1D71940
#
# git config --local -l  will list these with the names in lower case.
#
# NOTE: users should not use the configuration above when creating a
# different repository.  In particular, the 'SignWith' line must
# specify a GPG key fingerprint for which there is a private key in
# the user's keyring.
#
# Users must set up the debs.list file so it contains ".deb" files to put
# in the archive, one per line. After git was configured as described
# above, the user should run
#
#     make
#
# To rebuild the archive with a totally new configuration - that is
# without any existing members not listed in debs.list, use
#
#     make rebuild

# Citations:
# Using reprepro
# http://blog.jonliv.es/blog/2011/04/26/creating-your-own-signed-apt-repository-and-debian-packages/

# Location of Debian files copied to this archive.
# The file debs.list was not added to this git repository
# because it is system dependent.
#
# make all, or make with no arguments, will add files in debs.list
# to the archive.
#
DEBS = $(shell cat debs.list)


all: web/archive/conf/distributions $(DEBS)
	for i in $(DEBS) ; do \
	j=`basename $$i` ; \
	ln -s $$i $$j ; \
	reprepro -b web/archive/ includedeb hirsute $$j ; \
	rm -f $$j ; \
	done

# Rebuild the archive so it contains only the packages listed
# in debs.list. git rm is used to delete the unneeded files so
# that we can commit and push the new version.
#
rebuild: 
	rm -f web/archive/conf/distributions
	rm -fr web/archive/db
	rm -fr web/archive/dists
	rm -fr web/archvive/pool
	$(MAKE) web/archive/conf/distributions
	$(MAKE) all
	echo use git '"commit -a"' to make changes permanent

web/archive/conf/distributions:
	mkdir -p web/archive/conf
	echo Origin: `git config --local --get distributions.origin` > \
		web/archive/conf/distributions
	for i in Label Codename Architectures Components Description \
		SignWith ; \
	do echo $$i: `git config --local --get distributions.$$i` >> \
		web/archive/conf/distributions ; \
	done
