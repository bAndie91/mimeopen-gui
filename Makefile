PREFIX = /usr
EXEC_PREFIX = $(PREFIX)/bin

default:
	@echo maybe interested in: make install
	false
.PHONY: default

dependencies:
	# test if dependent perl modules are installed
	perl -c mimeopen-gui
.PHONY: dependencies

install: dependencies
	cp -v --no-preserve=ownership mimeopen-gui $(EXEC_PREFIX)
	cp -v --no-preserve=ownership mimeopen-gui.desktop $(PREFIX)/share/applications/
	update-desktop-database
	update-menus
	mkdir -p $(PREFIX)/share/doc/mimeopen-gui/
	cp -v --no-preserve=ownership LICENSE $(PREFIX)/share/doc/mimeopen-gui/
.PHONY: install

uninstall:
	[ ! -e $(EXEC_PREFIX)/mimeopen-gui ] || rm $(EXEC_PREFIX)/mimeopen-gui
	[ ! -e $(PREFIX)/share/applications/mimeopen-gui.desktop ] || rm $(PREFIX)/share/applications/mimeopen-gui.desktop
	update-desktop-database
	update-menus
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/LICENSE ] || rm $(PREFIX)/share/doc/mimeopen-gui/LICENSE
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/ ] || rmdir $(PREFIX)/share/doc/mimeopen-gui/
.PHONY: uninstall
