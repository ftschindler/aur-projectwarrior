#!/bin/bash
echo "building projectwarrior for current user from /usr/share/projectwarrior/src:"
# I cound not find a way to reliably deal with quicklisp (automated install
# and loading on sbcl startup), that did not depend on absolute file pathes.
# My workaround is to use a persistent dir as HOME to switch into when
# compiling, where we are sure of all locations.
BASEDIR=/usr/share/projectwarrior
_backuphome="${HOME}"
_fakehome="${HOME}/.local/share/projectwarrior"
# _fakehome="${BASEDIR}/sbcl"
#rm -rf "${_fakehome}" &> /dev/null
mkdir -p "${_fakehome}"
cp -r "${BASEDIR}/src/"* "${_fakehome}"
rm -rf "${_fakehome}/.git"* &> /dev/null
export HOME="${_fakehome}"

# due to the prescribed path, we can be sure to be the first to install, so this should not fail
sbcl --disable-debugger \
        --load '/usr/share/quicklisp/quicklisp.lisp' \
        --eval '(quicklisp-quickstart:install)' --quit &> /dev/null
# similarly, we are sure of the install location of quicklisp within that home
# and can use our shipped .sbclrc
cp "${BASEDIR}/sbclrc" "${HOME}/.sbclrc"

cd "${_fakehome}"
make build
echo "done"

echo "installing project to ${_backuphome}/.local/bin/project"
install -D -m 755 "/usr/share/projectwarrior/project.sh" "${_backuphome}/.local/bin/project"

