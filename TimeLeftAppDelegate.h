//
//  TimeLeftAppDelegate.h
//  TimeLeft
//
//  Created by Dave Arter on 04/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "iTunes.h"

@interface TimeLeftAppDelegate : NSObject { //<NSApplicationDelegate> {
//    NSWindow *window;
	NSStatusItem *statusItem;
	iTunesApplication *iTunes;
	NSTimer *appTimer;
}

//@property (assign) IBOutlet NSWindow *window;


- (void)timerFired:(NSTimer *)timer;

@end
