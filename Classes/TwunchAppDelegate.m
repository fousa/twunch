//
//  TwunchAppDelegate.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "TwunchAppDelegate.h"
#import "MCOverviewTwunchViewController.h"
#import "MCDetailViewController.h"
#import "MCWebViewController.h"
#import "MCMapViewController.h"
#import "MCParticipantsViewController.h"

@implementation TwunchAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	MCWebViewController *webController = [[MCWebViewController alloc] init];
	
	MCMapViewController *mapController = [[MCMapViewController alloc] init];
	
	MCParticipantsViewController *participantsController = [[MCParticipantsViewController alloc] init];
	participantsController.webController = webController;
	
	MCDetailViewController *detailController = [[MCDetailViewController alloc] init];
	detailController.mapController = mapController;
	detailController.participantsController = participantsController;
	
	MCOverviewTwunchViewController *overviewTwunchController = [[MCOverviewTwunchViewController alloc] init];
	overviewTwunchController.detailController = detailController;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:overviewTwunchController];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}

@end
