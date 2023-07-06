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
#       git config --local distributions.Codenames hirsute
#       git config --local --add distributions.Codenames impish
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
# the user's keyring.  Distributions.Codenames have multiple names listed
# because the Java packages are identical for multiple Debian releases.
#
# Users must set up the debs.list file so it contains ".deb" files to
# put in the archive, one per line. Similarly, the file inst.list must
# be set up to contain the initial path to the 'install' jar files
# (relative paths from the current directory are OK), followed by a
# tab and then a descriptive string, again one per line.  After git
# and this directory are configured as described above, the user
# should run
#
#     make
#
# To rebuild the archive with a totally new configuration - that is
# without any existing members not listed in debs.list and without
# keeping old installers, use
#
#     make rebuild

# Citations:
# Using reprepro
# http://blog.jonliv.es/blog/2011/04/26/creating-your-own-signed-apt-repository-and-debian-packages/

# Location of Debian files copied to this archive.  The file
# debs.list, which contains the locations of Debian files copied to
# this archive, was not added to this git repository because it is
# system dependent.  Similarly inst.list was not add.
#
# make all, or make with no arguments, will add files in debs.list
# to the archive.
#
DEBS = $(shell cat debs.list)

all: docs/archive/conf/distributions $(DEBS) docs/SecureBasic.html \
	docs/sbl-example.png
	@for i in $(DEBS) ; do \
	j=`basename $$i` ; \
	ln -s $$i $$j ; \
	for k in `git config --local --get-all distributions.codenames` ; \
	do reprepro -b docs/archive/ includedeb $$k $$j ; done ; \
	rm -f $$j ; \
	done
	@echo '# Direct links to Debian packages' > docs/packages.md
	@(cd docs ; \
	 for i in `find . -name '*.deb' | sort` ; \
	 do j=`echo $$i | cut -d / -f 6` ; \
	  echo ' ' >> packages.md ; \
	  echo '  - ['$$j']('$$i')' >> packages.md ; \
	  echo '    sha256:' `sha256sum $$i | cut -d ' ' -f 1` \
		>> packages.md ; \
	done )
	@make installers

listdebfiles:
	(cd docs ; \
	 for i in `find . -name '*.deb'` ; \
	 do j=`echo $$i | cut -d / -f 6` ; \
	  echo $$j $$i ; \
	done )


listdebs:
	for i in $(DEBS); do \
	j=`basename $$i` ; \
	echo $$j ; \
	done

# Rebuild the archive so it contains only the packages listed
# in debs.list. git rm is used to delete the unneeded files so
# that we can commit and push the new version.
#
rebuild: 
	rm -f docs/archive/conf/distributions
	rm -fr docs/archive/db
	rm -fr docs/archive/dists
	rm -fr docs/archive/pool
	rm -f docs/installers/*.jar
	$(MAKE) docs/archive/conf/distributions
	$(MAKE) all
	@echo run '"make add"' to add any new files
	@echo run '"git commit -a --gpg-sign=..."' to make changes permanent

#
# Need to use tail and head because the recursive make puts a line
# at the start and a line at the end.
# 
docs/archive/conf/distributions:
	mkdir -p docs/archive/conf
	make distributions | tail -n +2 | head -n -1 > \
		docs/archive/conf/distributions

distributions:
	@for j in `git config --local --get-all distributions.codenames` ; \
	do echo Origin: `git config --local --get distributions.origin` ; \
	   echo Codename: $$j ; \
	   for i in Label Architectures Components Description \
		SignWith ; \
	   do echo $$i: `git config --local --get distributions.$$i` ; \
	   done ; \
	   echo ; \
	done | head -n -1


docs/SecureBasic.html: ../libbzdev/src/SecureBasic.html
	sed -e 's/[.][.][/]stylesheet[.]css/bzdev.css/' $< > $@

docs/sbl-example.png: ../libbzdev/src/sbl-example.png
	cp ../libbzdev/src/sbl-example.png docs/sbl-example.png

#
# check that the links in DEBS are valid.
#
check-list:
	for i in $(DEBS) ; do \
		if [ -f $$i ] ; then \
		  echo  ... $$i OK ; \
		else \
		   /usr/bin/echo -e '***' $$i "\e[31mFAILED\e[0m" ; \
		   exit 1; \
		fi ; \
	done

#
# Add new debian packages (finish after the next try)
#
add:
	for i in `git status | grep ".deb" | grep -v ":" || echo -n` ; \
	do git add $$i ; done
	for i in `git config --local --get-all distributions.codenames` ; \
	do  j="docs/archive/dists/$$i" ; \
	    [ "`git status | grep $$j`" = "$$j" ] && git add $$i || echo -n ; \
	done
	for i in `git status | grep ".jar" | grep -v ":" || echo -n` ; \
	do git add $$i ; done

check-add:
	@for i in `git status | grep ".deb" | grep -v ":" || echo -n` ; \
	do echo git add $$i ; done
	@for i in `git config --local --get-all distributions.codenames` ; \
	do  j="docs/archive/dists/$$i" ; \
	    [ "`git status | grep $$j`" = "$$j" ] && echo git add $$i  \
		|| echo -n ; \
	done
	@for i in `git status | grep ".jar" | grep -v ":" || echo -n` ; \
	do echo git add $$i ; done

installers:
	@mkdir -p docs/installers
	@echo '# Installers' > docs/installers.md
	@echo -n The bzdev installer must be run before >> docs/installers.md
	@echo ' 'any of the other installers are run,  >> docs/installers.md
	@echo -n with the exception of cvrdecode and  >> docs/installers.md
	@echo ' 'qrlauncher. >> docs/installers.md
	@echo Each link below can be used to  >> docs/installers.md
	@echo download the jar file for an installer: >> docs/installers.md
	@sort -k 2 inst.list | while IFS= read -r entry ; do \
	   echo >> docs/installers.md ; \
	   i=`echo "$$entry" | cut -f 1` ; \
	   name=`echo "$$entry" | cut -f 2` ; \
	   j=`ls -rt $$i-*.jar | tail -1` ; \
	   jarfile=`basename $$j` ; \
	   cp $$j docs/installers/$$jarfile ; \
	   loc=https://billzaumen.github.io/bzdev/installers ; \
	   echo '  - ['$$name']('$$loc/$$jarfile')' >> docs/installers.md ; \
	   echo '    sha256:' `sha256sum $$j | cut -d ' '  -f 1`  \
		 >> docs/installers.md ; \
	done
	@echo >> docs/installers.md
	@echo To run an installer, use the command >> docs/installers.md
	@echo >> docs/installers.md
	@echo '```' >> docs/installers.md
	@echo >> docs/installers.md
	@echo sudo java -jar INSTALLER >> docs/installers.md
	@echo '```' >> docs/installers.md
	@echo >> docs/installers.md
	@echo where INSTALLER is a downloaded JAR file. >> docs/installers.md


#
# check that the initial paths in inst.list are valid. These paths
# exclude the version number and the ".jar" suffix
#
check-inst:
	@cat inst.list | while IFS= read -r entry ; do \
	   i=`echo "$$entry" | cut -f 1` ; \
	   j=`ls -rt $$i-*.jar | tail -1` ; \
	   if [ -z "$$j" ] ; then \
		   /usr/bin/echo -e '***' $$i "\e[31mFAILED\e[0m" ; \
		   exit 1; \
	   elif [ -f $$j ] ; then \
		  echo  ... $$i OK ; \
	   else \
		   /usr/bin/echo -e '***' $$i "\e[31mFAILED\e[0m" ; \
		   exit 1; \
	   fi ; \
	done


#
# Utility JAR files
#

utils: docs/utils/transfertest.jar

docs/utils/transfertest.jar: ../utils/transfertest.jar
	cp ../utils/transfertest.jar docs/utils/transfertest.jar

# Truncate history
truncate-history:
	ref=`git rev-list main~ ^main~~` ; \
	git checkout --orphan temp $ref ; \
	git commit -a -m "truncate history" ; \
	git rebase -onto temp $$ref main
	git branch -D temp
	git reflog expire --expire-unreachable=now --all
	git gc --prune=now
