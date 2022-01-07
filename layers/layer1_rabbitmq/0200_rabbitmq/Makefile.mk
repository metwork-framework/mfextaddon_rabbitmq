include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=rabbitmq-server
export VERSION=3.8.3
export EXTENSION=rpm
export CHECKTYPE=MD5
export CHECKSUM=8a0014d1adbf5aefae06bcd8df9300a1
DESCRIPTION=\
RABBITMQ is an open source multi-protocol messaging broker
WEBSITE=https://www.rabbitmq.com
LICENSE=MPL 1.1

all::$(PREFIX)/lib/rabbitmq/lib/rabbitmq_server
$(PREFIX)/lib/rabbitmq/lib/rabbitmq_server:
	mkdir -p $(PREFIX)/bin $(PREFIX)/lib $(PREFIX)/etc
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard download uncompress
	find build/usr -type f | xargs sed -i 's/\/usr\/lib\//$$MFEXT_HOME\/opt\/rabbitmq\/lib\//'
	find build/usr -type f | xargs sed -i 's/\/usr\/sbin\//$$MFEXT_HOME\/opt\/rabbitmq\/bin\//'
	find build/usr -type f | xargs sed -i 's/$${SYS_PREFIX}\/etc\//$$MFMODULE_RUNTIME_HOME\/var\//'
	find build/usr -type f | xargs sed -i 's/$${SYS_PREFIX}\/var\/lib\//$$MFMODULE_RUNTIME_HOME\/var\//'
	find build/usr -type f | xargs sed -i 's/$${SYS_PREFIX}\/var\/log\/rabbitmq/$$MFMODULE_RUNTIME_HOME/'
	cd build/usr && rm -rf sbin
	cd build/usr && cp -R * $(PREFIX)
	rm -f "$(PREFIX)/lib/rabbitmq/lib/rabbitmq_server"
	ln -s "$(PREFIX)/lib/rabbitmq/lib/rabbitmq_server-$(VERSION)" "$(PREFIX)/lib/rabbitmq/lib/rabbitmq_server"
