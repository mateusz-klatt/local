# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby31"
inherit ruby-ng multiprocessing

SLOT=0

SRC_URI="https://download.jetbrains.com/rider/JetBrains.Rider-${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Rider IDE by JetBrains"
HOMEPAGE="https://www.jetbrains.com/rider"

# JetBrains supports officially only x86_64 even though some 32bit binaries are
# provided. See https://www.jetbrains.com/go/download/#section=linux
KEYWORDS="~amd64"

LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual )
	Apache-2.0
	BSD
	CC0-1.0
	CDDL
	CDDL-1.1
	EPL-1.0
	GPL-2
	GPL-2-with-classpath-exception
	ISC
	LGPL-2.1
	LGPL-3
	MIT
	MPL-1.1
	OFL
	ZLIB
"

RESTRICT="bindist mirror"

QA_PREBUILT="opt/${P}/*"

S="${WORKDIR}/JetBrains Rider-${PV}"

RDEPEND="
	virtual/dotnet-sdk
	dev-dotnet/dotnet-sdk-bin
"

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
	fperms -R 755 "${dir}"

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "bin/${PN}.png" "${PN}.png"
	make_desktop_entry "${PN}" "rider" "${PN}" "Development;IDE;"
}
