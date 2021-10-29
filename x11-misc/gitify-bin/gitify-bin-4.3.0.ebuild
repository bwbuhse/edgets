# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# File was automatically generated by automatic-ebuild-maker
# https://github.com/BlueManCZ/automatic-ebuild-maker

EAPI=7
inherit unpacker xdg

DESCRIPTION="GitHub Notifications on your menu bar."
HOMEPAGE="https://www.gitify.io/"
SRC_URI="https://github.com/manosim/gitify/releases/download/v${PV}/gitify_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="appindicator doc libnotify system-ffmpeg system-mesa"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )
	system-ffmpeg? ( media-video/ffmpeg[chromium] )
	system-mesa? ( media-libs/mesa )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/gitify/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/gitify/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/gitify" || die "mv failed"
	fi

	if use system-ffmpeg ; then
		rm -f  "opt/Gitify/libffmpeg.so" || die "rm failed"
	fi

	if use system-mesa ; then
		rm -fr "opt/Gitify/swiftshader" || die "rm failed"
		rm -f  "opt/Gitify/libEGL.so" || die "rm failed"
		rm -f  "opt/Gitify/libGLESv2.so" || die "rm failed"
		rm -f  "opt/Gitify/libvk_swiftshader.so" || die "rm failed"
		rm -f  "opt/Gitify/libvulkan.so" || die "rm failed"
		rm -f  "opt/Gitify/libvulkan.so.1" || die "rm failed"
		rm -f  "opt/Gitify/vk_swiftshader_icd.json" || die "rm failed"
	fi

	sed -i "/^StartupWMClass=/{h;s/=.*/=gitify/}" usr/share/applications/gitify.desktop || die "sed failed"
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/gitify" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/gitify/"* || die "dodoc failed"
	fi

	if use system-ffmpeg ; then
		dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/Gitify/libffmpeg.so" || die "dosym failed"
	fi

	dosym "/opt/Gitify/gitify" "/usr/bin/gitify" || die "dosym failed"
}
