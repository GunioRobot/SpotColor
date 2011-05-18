//
//  AppController.m
//  Spot Color
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 zachwaugh.com. All rights reserved.
//

#import "AppController.h"

@implementation AppController

- (void)awakeFromNib
{
	NSColorPanel *colorPanel = [NSColorPanel sharedColorPanel];
	[colorPanel setTitle:@"Spot Color"];
	[colorPanel setShowsAlpha:YES];
	[colorPanel setDelegate:self];
	[colorPanel setFloatingPanel:[[NSUserDefaults standardUserDefaults] boolForKey:@"floatingPanel"]];
	[colorPanel setHidesOnDeactivate:NO];
	[colorPanel setShowsAlpha:YES];
	[colorPanel makeKeyAndOrderFront:nil];
	[colorPanel bind:@"floatingPanel" toObject:[NSUserDefaultsController sharedUserDefaultsController] withKeyPath:@"values.floatingPanel" options:nil];
	//check for developer panel and if existing then select
	for (NSToolbarItem *item in [[colorPanel toolbar] items]) {
		NSLog(@"%@", [item itemIdentifier]);
		if([item.itemIdentifier isEqualToString:@"com.apple.NSColorPanel.toolbarItem.DeveloperColorPicker"]){
			[[colorPanel toolbar] setSelectedItemIdentifier:[item itemIdentifier]];
			[NSApp sendAction:[item action] to:[item target] from:item];
			break;
		}
	}
}

// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
