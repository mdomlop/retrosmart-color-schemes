NAME = Retrosmart Color Schemes
EXECUTABLE = retrosmart-color-schemes
DESCRIPTION = Retrosmart color schemes for KDE Plasma.
VERSION = 0.1b
AUTHOR = Manuel Domínguez López
MAIL := $(shell echo zqbzybc@tznvy.pbz | tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
URL = https://github.com/mdomlop/$(EXECUTABLE)
LICENSE = GPL3


PREFIX = '/usr'
DESTDIR = ''

ARCHPKG = $(EXECUTABLE)-$(VERSION)-1-any.pkg.tar.xz

USERDIR := $(XDG_DATA_HOME)
ifeq ($(USERDIR),)
USERDIR := $(HOME)/.local/share/color-schemes
endif

SRCSCHEMES := $(wildcard src/*.colors)
SCHEMES := $(addsuffix .colors,$(addprefix $(DESTDIR)$(PREFIX)/share/color-schemes/,$(notdir $(basename $(SRCSCHEMES)))))
USERSCHEMES := $(addsuffix .colors,$(addprefix $(USERDIR)/,$(notdir $(basename $(SRCSCHEMES)))))

install: $(SCHEMES) install_docs

$(DESTDIR)$(PREFIX)/share/color-schemes/%.colors: src/%.colors
	install -Dm 644 $^ $@

install_docs: LICENSE README.md ChangeLog
	install -Dm 644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/$(EXECUTABLE)/COPYING
	install -Dm 644 README.md $(DESTDIR)$(PREFIX)/share/doc/$(EXECUTABLE)/README
	install -Dm 644 ChangeLog $(DESTDIR)$(PREFIX)/share/doc/$(EXECUTABLE)/ChangeLog

uninstall:
	rm -f $(PREFIX)/share/licenses/$(EXECUTABLE)
	rm -f $(PREFIX)/share/doc/$(EXECUTABLE)
	rm -f $(SCHEMES)

user_install: $(USERSCHEMES)

$(USERDIR)/%.colors: src/%.colors
	install -Dm 644 $^ $@

user_uninstall:
	rm -rf $(USERSCHEMES)

opendesktop: $(EXECUTABLE).tar.xz

$(EXECUTABLE).tar.xz: $(SRCSCHEMES)
	tar cJf $@ --xform='s,src/,,' $^

clean_opendesktop:
	rm -f $(EXECUTABLE).tar.xz

arch_clean:
	rm -rf pkg
	rm -f $(ARCHPKG)

clean: arch_clean clean_opendesktop

arch_pkg: PKGBUILD $(ARCHPKG)
PKGBUILD: Makefile
	sed -i "s|pkgname=.*|pkgname=$(EXECUTABLE)|" PKGBUILD
	sed -i "s|pkgver=.*|pkgver=$(VERSION)|" PKGBUILD
	sed -i "s|pkgdesc=.*|pkgdesc='$(DESCRIPTION)'|" PKGBUILD
	sed -i "s|url=.*|url='$(URL)'|" PKGBUILD
	sed -i "s|license=.*|license=('$(LICENSE)')|" PKGBUILD

$(ARCHPKG): PKGBUILD Makefile LICENSE README.md ChangeLog
	makepkg -df
	@echo
	@echo Package done!
	@echo You can install it as root with:
	@echo pacman -U $@

.PHONY: clean arch_clean uninstall
