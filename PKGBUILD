# Maintainer: Felix Schindler <aut at felixschindler dot net>

pkgname=projectwarrior
pkgver=0.3.2
pkgrel=2
pkgdesc="A tool to guide a user through a thorough weekly review in the GTD format."
arch=('x86_64')
url="https://github.com/jonathanabennett/projectwarrior"
license=('MIT')
depends=('quicklisp' 'sbcl')
source=('https://github.com/jonathanabennett/projectwarrior/archive/refs/tags/v0.3.2.tar.gz'
        'build-projectwarrior.sh'
        'project.sh'
        'projectwarrior.install'
        'sbclrc')
sha256sums=('b99a450df6fcfd8cd0731c98055720397fc9e2b163785c5978b04f4ae95b7e1a'
            '4d43ed8506ff55e45cce852d2eb25d35a9a96e7bf1d2229df55e88769ee5cfad'
            '09872180fb87aefa125edb49bb1d69eacc6220f16193b693959d1a8b83129d79'
            'e2b9f2f07cfeaea5ec663ef780d24f7ad1a7825744ed820f77249aa24f624aaa'
            '55f0a43e79aa754015c1d0c78627a79cc12d883e40965e4b660b61af59531086')
install='projectwarrior.install'

# The resulting projectwarrior executable is not usable without it's builddir,
# see also https://www.timmons.dev/posts/static-executables-with-sbcl.html.
# My undesirable quickfix is to build the actual executable in-place after
# installing everything to /usr/share/projectwarrior.
# We also build everything here to pacman will correctly associate all files we
# created with this package.

# I cound not find a way to reliably deal with quicklisp (automated install
# and loading on sbcl startup), that did not depend on absolute file pathes.
# My workaround is to use a persistent tmp dir as HOME to switch into when
# compiling, where we are sure of all locations.
_backuphome="${HOME}"
_fakehome="$(mktemp -d /tmp/aur-${pkgname}.XXXXXX)"

prepare() {
  # required workaround, see above
  export HOME=${_fakehome}
  # in this home, we can be sure to be the first to install, so this should not fail
  sbcl --disable-debugger --load '/usr/share/quicklisp/quicklisp.lisp' --eval '(quicklisp-quickstart:install)' --quit
  # similarly, we are sure of the install location of quicklisp within that home
  # and can use our shipped .sbclrc
  cp "${srcdir}/sbclrc" "${HOME}/.sbclrc"
}

build() {
  # required workaround, see above
  export HOME=${_fakehome}
  cd ${srcdir}/${pkgname}-${pkgver}
  make build
  export HOME=${_backuphome}
}

package() {
  mkdir -p "${pkgdir}/usr/share/${pkgname}"
  cp -ra "${srcdir}/${pkgname}-${pkgver}" "${pkgdir}/usr/share/${pkgname}/src"
  install -D -m 644 sbclrc "${pkgdir}/usr/share/${pkgname}/sbclrc"
  install -D -m 755 build-projectwarrior.sh "${pkgdir}/usr/share/${pkgname}/build-projectwarrior.sh"
  install -D -m 755 project.sh "${pkgdir}/usr/bin/project"
}
