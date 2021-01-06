PREFIX = /usr
EXEC_PREFIX = $(PREFIX)/bin

install:
	cp -v --no-preserve=ownership mimeopen-gui $(EXEC_PREFIX)
	cp -v --no-preserve=ownership mimeopen-gui.desktop $(PREFIX)/share/applications/
	mkdir -p $(PREFIX)/share/doc/mimeopen-gui/
	cp -v --no-preserve=ownership LICENSE $(PREFIX)/share/doc/mimeopen-gui/

uninstall:
	[ ! -e $(EXEC_PREFIX)/mimeopen-gui ] || rm $(EXEC_PREFIX)/mimeopen-gui
	[ ! -e $(PREFIX)/share/applications/mimeopen-gui.desktop ] || rm $(PREFIX)/share/applications/mimeopen-gui.desktop
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/LICENSE ] || rm $(PREFIX)/share/doc/mimeopen-gui/LICENSE
	[ ! -e $(PREFIX)/share/doc/mimeopen-gui/ ] || rmdir $(PREFIX)/share/doc/mimeopen-gui/
