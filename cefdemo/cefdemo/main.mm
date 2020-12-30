//
//  main.m
//  cefdemo
//
//  Created by Dongbiao on 10/28/20.
//


#include "include/cef_application_mac.h"
#include "include/cef_command_line.h"
#include "include/wrapper/cef_helpers.h"
#include "include/wrapper/cef_library_loader.h"
#include "simple_app.h"
#include "simple_handler.h"


#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"


@interface CefDemoApplication : NSApplication <CefAppProtocol>
{
@private
    BOOL handlingSendEvent_;
}
@end

@implementation CefDemoApplication

#pragma mark -- CefAppProtocal methods
- (BOOL)isHandlingSendEvent
{
    return handlingSendEvent_;
}

- (void)setHandlingSendEvent:(BOOL)handlingSendEvent
{
    handlingSendEvent_ = handlingSendEvent;
}

- (void)sendEvent:(NSEvent*)event
{
    CefScopedSendingEvent sendingEventScoper;
    [super sendEvent:event];
}

//- (void)terminate:(id)sender
//{
//    AppDelegate* delegate = static_cast<AppDelegate*>([NSApp delegate]);
//    [delegate tryToTerminateApplication:self];
//    // Return, don't exit. The application is responsible for exiting on its own.
//    //[super terminate:sender];
//}

@end


void processSignal(int sigid)
{
    if (SIGKILL == sigid)
    {
       // exit(0);
    }
}

int main(int argc, const char * argv[]) {
    
//    // Load the CEF framework library at runtime instead of linking directly
//    // as required by the macOS sandbox implementation.
//    CefScopedLibraryLoader library_loader;
//    if (!library_loader.LoadInMain())
//      return 1;
//
//    // Provide CEF with command-line arguments.
//    CefMainArgs main_args(argc, (char **)argv);
//
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
//
//        // Specify CEF global settings here.
//        CefSettings settings;
//#if !defined(CEF_USE_SANDBOX)
//        settings.no_sandbox = true;
//#endif
//
//        // SimpleApp implements application-level callbacks for the browser process.
//        // It will create the first browser instance in OnContextInitialized() after
//        // CEF has initialized.
//        CefRefPtr<SimpleApp> app(new SimpleApp);
//
//        // Initialize CEF for the browser process.
//        CefInitialize(main_args, settings, app.get(), NULL);
//
//
//
////        // Run the CEF message loop. This will block until CefQuitMessageLoop() is
////        // called.
////        CefRunMessageLoop();
////
////        // Shut down CEF.
////        CefShutdown();
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer){
//            CefDoMessageLoopWork();
//        }];
        
        
//        [CefDemoApplication sharedApplication];
//
//
//        // Create the application delegate.
//        NSObject* delegate =
//            [[AppDelegate alloc] init];
//        [delegate performSelectorOnMainThread:@selector(createApplication:)
//                                   withObject:nil
//                                waitUntilDone:NO];
    }
    
    signal(SIGKILL, processSignal);
    return NSApplicationMain(argc, argv);
    
//    while (true)
//    {
//        NSEvent *event;
//        event = [NSApp nextEventMatchingMask: NSEventMaskAny
//                                     untilDate: [NSDate distantPast]
//                                        inMode: NSDefaultRunLoopMode
//                                       dequeue: YES];
//        if (event != nil)
//            [NSApp sendEvent:event];
//
//
//        // FIXME: use external message pump integration
//        //CefDoMessageLoopWork();
//
//        // if you don't want to burn CPU, you could do this,
//        // but then you need to handle cef's schedulework messages.
//        //event = [NSApp nextEventMatchingMask: NSAnyEventMask
//        //                           untilDate: [NSDate distantFuture]
//        //                              inMode: NSDefaultRunLoopMode
//        //                             dequeue: NO];
//    }
}
