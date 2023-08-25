
# Maintainer: Gurjiwan Singh <gurrjiwan@gmail.com>
pkgname=uall
pkgver=v1.1.0
pkgrel=1
pkgdesc="Single Bash script to update packages using pacman yay and flatpak"
arch=('any')
url="https://github.com/Gurjiwan/uall"
license=('GPL3')
provides=("${pkgname%-VCS}")
source=('https://github.com/Gurjiwan/${pkgname}/releases/tag/${pkgver}.tar.gz')
md5sums=('SKIP')

# Please refer to the 'USING VCS SOURCES' section of the PKGBUILD man page for
# a description of each element in the source array.

pkgver() {
	cd "$srcdir/${pkgname%-VCS}"

# The examples below are not absolute and need to be adapted to each repo. The
# primary goal is to generate version numbers that will increase according to
# pacman's version comparisons with later commits to the repo. The format
# VERSION='VER_NUM.rREV_NUM.HASH', or a relevant subset in case VER_NUM or HASH
# are not available, is recommended.

# Git, tags available
	printf "%s" "$(git describe --long | sed 's/\([^-]*-\)g/r\1/;s/-/./g')"
}

prepare() {
	cd "$srcdir/${pkgname%-VCS}"
	patch -p1 -i "$srcdir/${pkgname%-VCS}.patch"
}

build() {
	cd "$srcdir/${pkgname%-VCS}"
	./autogen.sh
	./configure --prefix=/usr
	make
}

check() {
	cd "$srcdir/${pkgname%-VCS}"
	make -k check
}

package() {
	cd "$srcdir/${pkgname%-VCS}"
	make DESTDIR="$pkgdir/" install
}