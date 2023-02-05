# Maintainer: Felix Schindler <aut at felixschindler dot net>

pkgname=projectwarrior
pkgver=0.3.2
pkgrel=3
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
            '7857705bba951affe532b7f8c7ba151250ebcfb23290b08f054382902b0aa118'
            'a13f9e4dbbb274e9c9994aae3da049e5f1ecf0654ea5edc93e9b6eace430639c'
            '718561839de90534ffa0b6d03e00c31b165cf555086f3fd0d570ecec858b4467'
            '55f0a43e79aa754015c1d0c78627a79cc12d883e40965e4b660b61af59531086')
install='projectwarrior.install'

# The resulting projectwarrior executable is not usable without it's builddir,
# see also https://www.timmons.dev/posts/static-executables-with-sbcl.html.
# My undesirable quickfix is to build the actual executable in-place after
# installing everything to /usr/share/projectwarrior.

build() {
  echo "build is deferred to post install :/"
}

package() {
  mkdir -p "${pkgdir}/usr/share/${pkgname}"
  cp -ra "${srcdir}/${pkgname}-${pkgver}" "${pkgdir}/usr/share/${pkgname}/src"
  touch "${pkgdir}/usr/share/${pkgname}/src/projectwarrior"
  install -D -m 644 sbclrc "${pkgdir}/usr/share/${pkgname}/sbclrc"
  install -D -m 755 build-projectwarrior.sh "${pkgdir}/usr/share/${pkgname}/build-projectwarrior.sh"
  install -D -m 755 project.sh "${pkgdir}/usr/share/${pkgname}/project.sh"
}
