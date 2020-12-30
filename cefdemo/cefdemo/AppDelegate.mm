//
//  AppDelegate.m
//  cefdemo
//
//  Created by Dongbiao on 10/28/20.
//

#import "AppDelegate.h"


#include "include/cef_application_mac.h"
#include "include/cef_command_line.h"
#include "include/wrapper/cef_helpers.h"
#include "include/wrapper/cef_library_loader.h"
#include "simple_app.h"
#include "simple_handler.h"



@interface AppDelegate ()
{
}
- (int)startCef;
- (void)spinCefEventLoop;
@property (strong) IBOutlet NSWindow *window;
@property (strong) NSTimer *cefMessageLoopTimer;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self startCef];
    
}



- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication*)sender
{
    //[self tryToTerminateApplication:[NSApplication sharedApplication]];
    return NSTerminateNow;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self tryToTerminateApplication:[NSApplication sharedApplication]];
    // Shut down CEF.
    
//        for (int i = 0; i < 100; ++i) {
//          // Do some work.
//          CefDoMessageLoopWork();
//
//          // Sleep to allow the CEF proc to do work.
//          usleep(50000);
//        }
//    CefShutdown();
}

// Create the application on the UI thread.
- (void)createApplication:(id)object {
    // Chrome will create the top-level menu programmatically in
    // chrome/browser/ui/cocoa/main_menu_builder.h
    // TODO(chrome-runtime): Expose a way to customize this menu.
    [[NSBundle mainBundle] loadNibNamed:@"MainMenu"
                                  owner:NSApp
                        topLevelObjects:nil];

    // Set the delegate for application events.
    [[NSApplication sharedApplication] setDelegate:self];
}


- (int)startCef
{
    // Load the CEF framework library at runtime instead of linking directly
    // as required by the macOS sandbox implementation.
    CefScopedLibraryLoader library_loader;
    if (!library_loader.LoadInMain())
      return 1;
    
    // Provide CEF with command-line arguments.
    CefMainArgs main_args;
    
   // @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.

        // Specify CEF global settings here.
        CefSettings settings;
#if !defined(CEF_USE_SANDBOX)
        settings.no_sandbox = true;
#endif
        //settings.external_message_pump = true;
        // SimpleApp implements application-level callbacks for the browser process.
        // It will create the first browser instance in OnContextInitialized() after
        // CEF has initialized.
        CefRefPtr<SimpleApp> app(new SimpleApp);
    
        
        
        app.get()->SetHostWindow((__bridge void *)self.window.contentView);

        // Initialize CEF for the browser process.
        CefInitialize(main_args, settings, app.get(), NULL);

        
//        // Run the CEF message loop. This will block until CefQuitMessageLoop() is
//        // called.
//        CefRunMessageLoop();
//
//        // Shut down CEF.
//        CefShutdown();
        
//    CefDoMessageLoopWork();
    
        self.cefMessageLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer *timer){
            CefDoMessageLoopWork();
        }];
    
//        [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskAny handler: ^(NSEvent *event){
//            [self performSelectorOnMainThread:@selector(spinCefEventLoop) withObject:nil waitUntilDone:NO];
//            
//            return event;
//        }];

//    }
    
    return 0;
}

- (void)spinCefEventLoop
{
    CefDoMessageLoopWork();
}


- (void)tryToTerminateApplication:(NSApplication*)app
{
    [self.cefMessageLoopTimer invalidate];
    self.cefMessageLoopTimer = nil;
    
    SimpleHandler* handler = SimpleHandler::GetInstance();
    if (handler && !handler->IsClosing())
        handler->CloseAllBrowsers(false);

    //[self.window performClose:nil];
    

    CefShutdown();
    
    
    // We need to run the message pump until it is idle. However we don't have
    // that information here so we run the message loop "for a while".
//    for (int i = 0; i < 10; ++i) {
//      // Do some work.
//      CefDoMessageLoopWork();
//
//      // Sleep to allow the CEF proc to do work.
//      usleep(50000);
//    }

    
    //CefShutdown();
}


//- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
//{
//    return YES;
//}

#pragma mark --NSWindowDelegate Method
//
//- (BOOL)windowShouldClose:(NSWindow *)sender
//{
//    SimpleHandler* handler = SimpleHandler::GetInstance();
//    if (handler)
//        handler->CloseAllBrowsers(false);
//    return YES;
//}

@end
