include ../../../adm/root.mk
include $(MFEXT_HOME)/share/simple_layer.mk

ifeq ($(shell cat /etc/redhat-release |grep -c "CentOS release 6"), 1)

#erlang (of which we are using binaries without building it by ourselves) links
#with libcrypto.so.10. As we are not building it, we can't tell erlang to use 
#libcrypto.45.so provided by core@mfext. But libcrypto.so.10 is not available on
#some linux distributions such as Debian. So we need to copy it from CentOS6.

LIB_LIST = $(shell cat libraries.txt)
$(shell mkdir $(PREFIX)/lib)

all:: $(PREFIX)/lib/libcrypto.so.10
$(PREFIX)/lib/libcrypto.so.10:
	for lib in $(LIB_LIST); do cp -r $$lib $(PREFIX)/lib; done
endif
