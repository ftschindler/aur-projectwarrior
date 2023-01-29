# Maintainer: Felix Schindler <aut at felixschindler dot net>

pkgname=projectwarrior
pkgver=0.3.2
pkgrel=1
pkgdesc="A tool to guide a user through a thorough weekly review in the GTD format."
arch=('x86_64')
url="https://github.com/jonathanabennett/projectwarrior"
license=('MIT')
makedepends=('quicklisp' 'sbcl')
source=('https://github.com/jonathanabennett/projectwarrior/archive/refs/tags/v0.3.2.tar.gz'
        'project.sh'
        'projectwarrior.install'
        'sbclrc')
sha256sums=('b99a450df6fcfd8cd0731c98055720397fc9e2b163785c5978b04f4ae95b7e1a'
            'f86c01f4db3c97c26f57854e418c11bfac94588764ae78c8e523c902e309117f'
            '0856a3130509f1410185c85172cc28ac525e321dd40c03a3b10140aeb0a79321'
            '55f0a43e79aa754015c1d0c78627a79cc12d883e40965e4b660b61af59531086')
install='projectwarrior.install'

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
  # The resulting projectwarrior executable is not usable without it's builddir,
  # see also https://www.timmons.dev/posts/static-executables-with-sbcl.html
  mkdir -p "${pkgdir}/usr/share"
  cp -ra "${srcdir}/${pkgname}-${pkgver}" "${pkgdir}/usr/share/${pkgname}"
  install -D -m 755 project.sh "${pkgdir}/usr/bin/project"
}
