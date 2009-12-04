//
//  TimeLeftAppDelegate.m
//  TimeLeft
//
//  Created by Dave Arter on 04/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <ScriptingBridge/ScriptingBridge.h>

#import "TimeLeftAppDelegate.h"

@implementation TimeLeftAppDelegate

//@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	
	[statusItem setHighlightMode:NO];
	[statusItem setTitle:@""];
	[statusItem setEnabled:YES];
	
	appTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5f
												target:self
											  selector:@selector(timerFired:)
											  userInfo:nil
											   repeats:YES] retain];
}

- (void)timerFired:(NSTimer *)timer
{
	if ([iTunes isRunning] && iTunes.playerState == iTunesEPlSPlaying) {
		NSInteger trackLength = (NSInteger) iTunes.currentTrack.finish;
		NSInteger playbackPosition = iTunes.playerPosition;
		NSInteger timeRemaining = (trackLength - playbackPosition);
		NSLog(@"%d", timeRemaining);
		timeRemaining = MAX(0, timeRemaining);
		NSLog(@"%d", timeRemaining);
		
		// Parse that shit into a nice human-readable string!
		int hours = timeRemaining / (60*60);
		int mins = (timeRemaining % (60*60)) / 60;
		int secs = timeRemaining % 60;
		
		NSString *titleText;
		if (hours > 0)
			titleText = [NSString stringWithFormat:@"-%d:%02d:%02d", hours, mins, secs];
		else
			titleText = [NSString stringWithFormat:@"-%d:%02d", mins, secs];
		
		[statusItem setTitle:titleText];
	} else {
		[statusItem setTitle:@""];
	}
}

- (void) dealloc {
	[appTimer invalidate];
	[appTimer release];
	[statusItem release];
	[super dealloc];
}

@end
