CFLAGS ?= -Wall

cocoa.o: cocoa.m
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

cocoa: cocoa.o
	$(CC) $(CFLAGS) -framework Cocoa $< -o $@
