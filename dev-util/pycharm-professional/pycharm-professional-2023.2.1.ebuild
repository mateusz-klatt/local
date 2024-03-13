# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop readme.gentoo-r1 wrapper

MY_PN=${PN/-professional/}
DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis"
HOMEPAGE="https://www.jetbrains.com/pycharm/"
SRC_URI="https://download.jetbrains.com/python/${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="PyCharm_Academic PyCharm_Classroom PyCharm PyCharm_OpenSource PyCharm_Preview"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bundled-jdk"
RESTRICT="mirror"

RDEPEND="!bundled-jdk? ( >=virtual/jre-1.8 )
	dev-python/pip
	media-fonts/dejavu
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libXtst
	x11-libs/libXxf86vm
"
BDEPEND="dev-util/patchelf"

QA_PREBUILT="opt/${PN}/*"

src_install() {
	local dir="/opt/${PN}"
	local jre_dir="jbr"

	insinto ${dir}
	doins -r *

	fperms -R 755 ${dir}
	fperms 755 ${dir}/${jre_dir}/bin/*
	fperms 755 ${dir}/${jre_dir}/lib/*.so
	fperms 755 ${dir}/${jre_dir}/lib/*.so.*
	fperms 755 ${dir}/${jre_dir}/lib/*/*.so
	fperms 755 ${dir}/${jre_dir}/lib/*.bin
	fperms 755 ${dir}/${jre_dir}/lib/j*
	fperms 755 ${dir}/${jre_dir}/lib/c*

	make_wrapper ${PN} ${dir}/bin/pycharm.sh
	newicon bin/${MY_PN}.png ${PN}.png
	make_desktop_entry "${PN}" "PyCharm Ultimate Edition" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	insinto /usr/lib/sysctl.d
	newins - 30-idea-inotify-watches.conf <<<"fs.inotify.max_user_watches = 524288"
}
