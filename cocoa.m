#import <Cocoa/Cocoa.h>
#import <ApplicationServices/ApplicationServices.h>

int main ()
{
  [NSApplication sharedApplication];
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  id applicationName = [[NSProcessInfo processInfo] processName];
  id window = [[NSWindow alloc]
    initWithContentRect:NSMakeRect(0, 0, 120, 120)
    styleMask:NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask
    backing:NSBackingStoreBuffered defer:NO];

  [window center];
  [window setTitle: applicationName];
  [window makeKeyAndOrderFront:nil];
  [NSApp activateIgnoringOtherApps:YES];

  id applicationMenuBar = [[NSMenu alloc] initWithTitle: @"Menu"];
  [applicationMenuBar addItemWithTitle: @"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
  [applicationMenuBar addItemWithTitle: @"Hello item" action: NULL keyEquivalent:@""];
  [NSApp performSelector:NSSelectorFromString(@"setAppleMenu:") withObject:applicationMenuBar];

  [NSApp run];
  [pool release];

  return 0;
}
