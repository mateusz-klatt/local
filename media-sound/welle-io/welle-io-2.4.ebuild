# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils

MY_PN="welle.io"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A DAB/DAB+ Software Radio"
HOMEPAGE="http://www.welle.io/"
SRC_URI="https://github.com/AlbrechtL/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-qt/qtcharts:5[qml]
		dev-qt/qtdeclarative:5
		dev-qt/qtmultimedia:5
		dev-qt/qtquickcontrols:5
		dev-qt/qtquickcontrols2:5
		net-wireless/rtl-sdr
		sci-libs/fftw:3.0
		virtual/glu
		virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	eapply_user
}

src_configure() {
	eqmake5
}

src_install() {
	# Performing a manual installation as "make install" is not implemented.
	dodoc README.md
	newicon src/welle-gui/icons/icon.png "${PN}.png"
	domenu "${PN}.desktop"
	dobin "src/welle-gui/welle-io"
}
