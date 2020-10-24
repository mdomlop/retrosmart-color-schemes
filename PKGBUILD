# Maintainer: Manuel Domínguez López
# <mdomlop at gmail dot com>
# @mdomlop at telegram

_pkgver_year=2019
_pkgver_month=12
_pkgver_day=14

pkgname=retrosmart-color-schemes
pkgver=0.1b
pkgrel=1
pkgdesc='Retrosmart color schemes for KDE Plasma.'
url='https://github.com/mdomlop/retrosmart-color-schemes'
source=()
license=('GPL3')
optdepends=('xcursors-retrosmart: The corresponding cursors theme.'
            'retrosmart-icon-theme: The corresponding icon theme.'
			'retrosmart-aurorae-themes: The corresponding Aurorae themes.'
            'retrosmart-xfwm4-themes: The corresponding themes for XFwm4.'
            'retrosmart-openbox-themes: The corresponding themes for Openbox.'
            'retrosmart-kvantum-theme: The corresponding theme for Kvantum.'
            'retrosmart-qtcurve-theme: The corresponding theme for QtCurve'.)
arch=('any')
group=('retrosmart')
changelog=ChangeLog

package() {
    cd "$startdir"
    make DESTDIR=$pkgdir
}
