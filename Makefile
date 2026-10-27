INSTALL_WRAPPER =
PREFIX = /usr
EXEC_PREFIX = $(PREFIX)/bin

default:
	$(error try `make install INSTALL_WRAPPER=sudo´)
.PHONY: default

dependencies:
	# test if dependent perl modules are installed
	perl -c mimeopen-gui
.PHONY: dependencies

install: dependencies
	$(INSTALL_WRAPPER) cp -v --no-preserve=ownership mimeopen-gui $(EXEC_PREFIX)
	$(INSTALL_WRAPPER) cp -v --no-preserve=ownership mimeopen-gui.desktop $(PREFIX)/share/applications/
	$(INSTALL_WRAPPER) update-desktop-database
	$(INSTALL_WRAPPER) update-menus
	$(INSTALL_WRAPPER) mkdir -p $(PREFIX)/share/doc/mimeopen-gui/
	$(INSTALL_WRAPPER) cp -v --no-preserve=ownership LICENSE $(PREFIX)/share/doc/mimeopen-gui/
.PHONY: install

uninstall:
	[ ! -e $(EXEC_PREFIX)/mimeopen-gui ] || $(INSTALL_WRAPPER) rm $(EXEC_PREFIX)/mimeopen-gui
	[ ! -e $(PREFIX)/share/applications/mimeopen-gui.desktop ] || $(INSTALL_WRAPPER) rm $(PREFIX)/share/applications/mimeopen-gui.desktop
	$(INSTALL_WRAPPER) update-desktop-database
	$(INSTALL_WRAPPER) update-menus
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/LICENSE ] || $(INSTALL_WRAPPER) rm $(PREFIX)/share/doc/mimeopen-gui/LICENSE
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/ ] || $(INSTALL_WRAPPER) rmdir $(PREFIX)/share/doc/mimeopen-gui/
.PHONY: uninstall
