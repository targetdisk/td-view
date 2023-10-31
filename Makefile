CFLAGS ?= -Wall
FRAMEWORKS = -framework AppKit -framework Cocoa

catalog:
	./build.pl

var/out/minivx:
	./build.pl -i minivx

minivx: var/out/minivx

%.app/Contents/Info.plist:
	PATH="$(PATH):var/out" minivx -Ze 'dup2(rewrite argv[1], fd 1); run argv[2..3]' \
		"$@" modules/metamage_1/bin/make-info-plist Info.txt

%.o: %.m
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

td-view: main.o AppDelegate.o
	$(CC) $(CFLAGS) $(FRAMEWORKS) $? -o $@

%.app/Contents: %
	mkdir -p "$@/"{Resources,MacOS}
	cp "$*" "$@/MacOS/$*"

%.app: minivx
	$(MAKE) "$@/Contents"{,/Info.plist}

clean:
	rm -vf cocoa *.o
	rm -rf *.app
	rm -rf var/{out,build,cache}

.PHONY: clean catalog minivx
