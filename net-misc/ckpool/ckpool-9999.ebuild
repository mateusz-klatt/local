# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic systemd

DESCRIPTION="solo bitcoin mining"
HOMEPAGE="https://solo.ckpool.org/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="
	dev-libs/gmp:=
	dev-libs/jansson:=
	>=net-misc/curl-7.15[ssl]
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"
if [[ ${PV} == "9999" ]] ; then
    KEYWORDS="~amd64"
	SRC_URI=""
	EGIT_REPO_URI="https://bitbucket.org/ckolivas/ckpool.git"
	inherit git-r3
else
	KEYWORDS="~amd64"
	SRC_URI="http://ck.kolivas.org/apps/soloproxy/soloproxy-0.9.5.tar.bz2"
fi

PATCHES=(
	"${FILESDIR}/global_ckp.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --with-crypto --with-curl
	cd src/jansson-2.10
	make
}

src_install() {
	default
}

src_test() {
	./cpuminer --cputest || die
}
