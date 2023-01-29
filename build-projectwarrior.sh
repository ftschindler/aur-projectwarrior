#!/bin/bash
echo -n "building projectwarrior in /usr/share/projectwarrior/src ... "
# I cound not find a way to reliably deal with quicklisp (automated install
# and loading on sbcl startup), that did not depend on absolute file pathes.
# My workaround is to use a persistent tmp dir as HOME to switch into when
# compiling, where we are sure of all locations.
_backuphome="${HOME}"
_fakehome="$(mktemp -d /tmp/aur-${pkgname}.XXXXXX)"
BASEDIR=/usr/share/projectwarrior

export HOME=${_fakehome}
# in this home, we can be sure to be the first to install, so this should not fail
sbcl --disable-debugger --load '/usr/share/quicklisp/quicklisp.lisp' --eval '(quicklisp-quickstart:install)' --quit &> /dev/null
# similarly, we are sure of the install location of quicklisp within that home
# and can use our shipped .sbclrc
cp "${BASEDIR}/sbclrc" "${HOME}/.sbclrc"

cd "${BASEDIR}/src"
make build
echo "done"

