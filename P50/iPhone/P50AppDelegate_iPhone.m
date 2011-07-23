//
//  P50AppDelegate_iPhone.m
//  P50
//
//  Created by Sergio Botero on 4/24/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "P50AppDelegate_iPhone.h"
#import "LasVegasViewController.h"
#import "UIColor+SBColors.h"

@implementation P50AppDelegate_iPhone


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	LasVegasViewController * viewController = [[LasVegasViewController alloc] init];
	
	mainEntrance = [[UINavigationController alloc] initWithRootViewController:viewController];
	
	mainEntrance.navigationBar.tintColor = [UIColor blueP50];
	[self.window addSubview: mainEntrance.view];

	[self.window makeKeyAndVisible];
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
	[viewController release];
    return YES;

}

- (void)dealloc
{
	[mainEntrance release];
	[super dealloc];
}

@end
