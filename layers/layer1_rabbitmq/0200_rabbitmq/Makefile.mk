include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=rabbitmq-server
export VERSION=3.8.3
export EXTENSION=rpm
export CHECKTYPE=MD5
export CHECKSUM=3bd46e0d990ea2babc37df1aefe836c8
DESCRIPTION=\
RABBITMQ is an open source multi-protocol messaging broker
WEBSITE=https://www.rabbitmq.com
LICENSE=MPL 1.1

all::$(PREFIX)/lib/rabbitmq/lib/$(NAME)-$(VERSION)/sbin/rabbitmq-server
$(PREFIX)/lib/rabbitmq/lib/$(NAME)-$(VERSION)/sbin/rabbitmq-server:
	mkdir -p $(PREFIX)/bin $(PREFIX)/lib $(PREFIX)/etc
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard download uncompress
	find build/usr -type f | xargs sed -i 's/\/usr\/lib\//$$MFEXT_HOME\/opt\/rabbitmq\/lib\//'
	find build/usr -type f | xargs sed -i 's/\/usr\/sbin\//$$MFEXT_HOME\/opt\/rabbitmq\/bin\//'
	cd build/usr && rm -rf bin && mv sbin bin
	cd build && cp -R etc $(PREFIX)
	cd build/usr && cp -R * $(PREFIX)
