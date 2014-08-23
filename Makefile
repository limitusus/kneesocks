CC = gcc
OBJS = kneesocks libkneesocks.so
PREFIX = /usr/local

all: $(OBJS)

clean:
	rm -f $(OBJS)

install:
	install -m 755 kneesocks $(PREFIX)/bin/kneesocks
	install -m 644 libkneesocks.so $(PREFIX)/lib/libkneesocks.so
	echo $(PREFIX)/lib > /etc/ld.so.conf.d/libkneesocks.conf
	ldconfig

uninstall:
	rm -f $(PREFIX)/bin/kneesocks
	rm -f $(PREFIX)/lib/libkneesocks.so
	rm -f /etc/ld.so.conf.d/libkneesocks.conf
	ldconfig

kneesocks: kneesocks.c
	$(CC) -o $@ $<

libkneesocks.so: libkneesocks.c
	$(CC) -shared -fPIC -o $@ $< -ldl
