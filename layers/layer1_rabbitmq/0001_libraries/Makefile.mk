include ../../../adm/root.mk
include $(MFEXT_HOME)/share/simple_layer.mk

#erlang (of which we are using binaries without building it by ourselves) links
#with /usr/lib64/libcrypto.so.1.1. which is not available on recent linux 
#distributions (fedora >= 40). So we need to copy it from el8.

LIB_LIST = $(shell cat libraries.txt)
$(shell mkdir $(PREFIX)/lib)

all:: $(PREFIX)/lib/libcrypto.so.1.1
$(PREFIX)/lib/libcrypto.so.1.1:
	for lib in $(LIB_LIST); do cp -r $$lib $(PREFIX)/lib; done
