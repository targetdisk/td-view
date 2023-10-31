CFLAGS ?= -Wall
FRAMEWORKS = -framework AppKit -framework Cocoa

%.o: %.m
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

td-view: main.o AppDelegate.o
	$(CC) $(CFLAGS) $(FRAMEWORKS) $? -o $@

clean:
	rm -vf cocoa *.o
	rm -rf *.app

catalog:
	./build.pl

minivx: catalog
	./build.pl -i minivx
	#./build.pl -i minivx varyx-posix vlib

%.app/Contents/Info.plist:
	PATH="$(PATH):var/out" minivx -Ze 'dup2(rewrite argv[1], fd 1); run argv[2..3]' \
		"$@" modules/metamage_1/bin/make-info-plist Info.txt

%.app/Contents: %
	mkdir -p "$@/"{Resources,MacOS}
	cp "$*" "$@/MacOS/$*"

%.app: minivx
	$(MAKE) "$@/Contents"{,/Info.plist}

.PHONY: clean catalog
