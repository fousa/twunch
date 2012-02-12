//
//  MCDetailViewController.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <Twitter/Twitter.h>

#import "MCDetailViewController.h"
#import "MCDetailView.h"
#import "MCParticipantButton.h"
#import "MCOverviewTwunchTableView.h"

@implementation MCDetailViewController

@synthesize mapController;
@synthesize participantsController;
@synthesize twunch;

#pragma mark Overridden methods

- (void)loadView {
	[super loadView];

	self.title = @"Twunch";

	MCOverviewTwunchTableView *tableView = [[MCOverviewTwunchTableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
	[tableView release];

	refreshView = [[MCRefreshView alloc] initFromView:self.tableView];
	refreshView.text = @"Subscribing";
	refreshView.tag = 1000;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark Delegation methods for the UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 416;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *twitterName = [[NSUserDefaults standardUserDefaults] objectForKey: @"authUsername"];
	MCDetailView *view = [[MCDetailView alloc] initWithFrame:CGRectZero twunch:twunch twitterName:twitterName];
	view.backgroundColor = [UIColor clearColor];
	view.subscribed = YES;
	view.controller = self;
	return view;
}

#pragma mark Personal methods

- (void)setRefreshView {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	[self.tableView.window addSubview:refreshView];
	[pool release];
}

- (void)subscribeWithAlert {
    if (self.twunch.closed) {
	    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sad panda" message:@"This twunch is fully booked." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
	} else {
        [self subscribe];
    }
}

- (void)subscribe {
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    [twitter addURL:[NSURL URLWithString:[NSString stringWithString:twunch.link]]];
    [twitter setInitialText:[NSString stringWithFormat:@"(%@) @twunch I'll be there!", twunch.name]];
    
    // Show the controller
    [self presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        NSString *title = @"Twitter";
        NSString *message; 
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            message = @"No Twunch for you...";
        else if (result == TWTweetComposeViewControllerResultDone)
            message = @"Subscribed to this twunch!";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };
}

- (void)goToMapView {
	mapController.twunch = twunch;
	[self.navigationController pushViewController:mapController animated:YES];
}

- (void)goToParticipantsView {
	participantsController.twunch = twunch;
	[self.navigationController pushViewController:participantsController animated:YES];
}

- (void)reloadData {
	[self.tableView reloadData];
}

@end
