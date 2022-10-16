# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# File was automatically generated by automatic-ebuild-maker
# https://github.com/BlueManCZ/automatic-ebuild-maker

EAPI=8
inherit unpacker xdg

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com"
SRC_URI="amd64? ( https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-amd64.deb -> simplenote-${PV}-amd64.deb )
	x86? ( https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-i386.deb -> simplenote-${PV}-i386.deb )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist mirror"
IUSE="doc system-ffmpeg system-mesa"

RDEPEND="dev-libs/nss
	gnome-base/gconf:2
	net-print/cups
	x11-libs/libXScrnSaver
	system-ffmpeg? ( media-video/ffmpeg[chromium] )
	system-mesa? ( media-libs/mesa )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/simplenote/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/simplenote/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/simplenote" || die "mv failed"
	fi

	if use system-ffmpeg ; then
		rm -f  "opt/Simplenote/libffmpeg.so" || die "rm failed"
	fi

	if use system-mesa ; then
		rm -fr "opt/Simplenote/swiftshader" || die "rm failed"
		rm -f  "opt/Simplenote/libEGL.so" || die "rm failed"
		rm -f  "opt/Simplenote/libGLESv2.so" || die "rm failed"
		rm -f  "opt/Simplenote/libvk_swiftshader.so" || die "rm failed"
		rm -f  "opt/Simplenote/libvulkan.so" || die "rm failed"
		rm -f  "opt/Simplenote/libvulkan.so.1" || die "rm failed"
		rm -f  "opt/Simplenote/vk_swiftshader_icd.json" || die "rm failed"
	fi
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/simplenote" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/simplenote/"* || die "dodoc failed"
	fi

	if use system-ffmpeg ; then
		dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/Simplenote/libffmpeg.so" || die "dosym failed"
	fi

	dosym "/opt/Simplenote/simplenote" "/usr/bin/simplenote" || die "dosym failed"
}
