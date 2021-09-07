include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

export NAME=erlang
export VERSION=22.3
export EXTENSION=rpm
export CHECKTYPE=MD5
export CHECKSUM=99d95be2bc9d55dca3d4e96f6f45e102
DESCRIPTION=\
This is a (virtually) zero dependency 64-bit Erlang RPM package that provides just enough to run RabbitMQ. It may be easier to install than other Erlang RPMs in most environments. It may or may not be suitable for running other Erlang-based software or 3rd party RabbitMQ plugins.²
WEBSITE=https://github.com/rabbitmq/erlang-rpm
LICENSE=Apache 2.0

all::$(PREFIX)/lib/erlang/bin/epmd
$(PREFIX)/lib/erlang/bin/epmd:
	mkdir -p $(PREFIX)/bin $(PREFIX)/lib
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard download uncompress
	find build/usr -type f | xargs sed -i 's/\/usr\/lib64/$$MFEXT_HOME\/opt\/rabbitmq\/lib/'
	cd build/usr/lib64 && cp -R * $(PREFIX)/lib
	cd $(PREFIX)/bin && ln -s ../lib/erlang/bin/to_erl to_erl && ln -s ../lib/erlang/bin/run_erl run_erl && ln -s ../lib/erlang/bin/escript escript && ln -s ../lib/erlang/bin/erlc erlc && ln -s ../lib/erlang/bin/erl erl && ln -s ../lib/erlang/bin/epmd epmd
