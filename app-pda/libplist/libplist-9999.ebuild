# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit autotools git-r3

DESCRIPTION="libplist"
HOMEPAGE="https://github.com/libimobiledevice/libplist.git"
EGIT_REPO_URI="https://github.com/libimobiledevice/libplist.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libusb:1
        sys-libs/readline"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
