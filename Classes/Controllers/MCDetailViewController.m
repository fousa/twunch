//
//  MCDetailViewController.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

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
    
//    engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
//    
//    NSDictionary *twitter = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter" ofType:@"plist"]];
//    engine.consumerKey = [twitter valueForKey:@"consumer_key"];
//	engine.consumerSecret = [twitter valueForKey:@"consumer_secret"];

	refreshView = [[MCRefreshView alloc] initFromView:self.tableView];
	refreshView.text = @"Subscribing";
	refreshView.tag = 1000;
}

- (void)dealloc {
//	[engine release];
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
//	if (![engine isAuthorized]) {
//		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//		[defaults setObject:@"" forKey: @"authData"];
//		[defaults setObject:@"" forKey: @"authUsername"];
//		[defaults synchronize];
//	}

	NSString *twitterName = [[NSUserDefaults standardUserDefaults] objectForKey: @"authUsername"];
	MCDetailView *view = [[MCDetailView alloc] initWithFrame:CGRectZero twunch:twunch twitterName:twitterName];
	view.backgroundColor = [UIColor clearColor];
	view.subscribed = YES;
	view.controller = self;
	return view;
}

//#pragma mark Methods for SA_OAuthTwitterEngineDelegate
//
//- (void)storeCachedTwitterOAuthData:(NSString *)data forUsername:(NSString *)username {
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	[defaults setObject:data forKey: @"authData"];
//	[defaults synchronize];
//}
//
//- (NSString *)cachedTwitterOAuthDatForUsername:(NSString *)username {
//	NSString *cachedData = [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
//	return cachedData;
//}

//#pragma mark Methods for SA_OAuthTwitterControllerDelegate
//
//- (void)OAuthTwitterController:(SA_OAuthTwitterController *)conOtroller authenticatedWithUsername:(NSString *)username {
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	[defaults setObject:username forKey: @"authUsername"];
//	[defaults synchronize];
//	[engine sendUpdate:[NSString stringWithFormat:@"(%@) @twunch I'll be there! %@", twunch.name, twunch.link]];
//}
//
//- (void)OAuthTwitterControllerFailed:(SA_OAuthTwitterController *)controller {
//
//}
//
//- (void)OAuthTwitterControllerCanceled:(SA_OAuthTwitterController *)controller {
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	[defaults setObject:@"" forKey: @"authData"];
//	[defaults setObject:@"" forKey: @"authUsername"];
//	[defaults synchronize];
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Failed to authenticate with twitter, please try again" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
//}
//
//#pragma mark Methods for TwitterEngineDelegate
//
//- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error {
//	[[self.tableView.window viewWithTag:1000] removeFromSuperview];
//	if ([error code] == 401) {
//		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//		[defaults setObject:@"" forKey: @"authData"];
//		[defaults setObject:@"" forKey: @"authUsername"];
//		[defaults synchronize];
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Failed to authenticate with twitter, please try again" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
//		[alert show];
//		[alert release];
//	} else {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Failed to subscribe to this twunch, please try again" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
//		[alert show];
//		[alert release];
//	}
//}
//
//- (void)requestSucceeded:(NSString *)requestIdentifier {
//	[[self.tableView.window viewWithTag:1000] removeFromSuperview];
//	
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Subscribed" message:@"You subscribed successfully to this twunch!" delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
//	[alert show];
//	[alert release];
//}

#pragma mark Methods for UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self subscribe];
	}
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Subscribe?" message:@"Are you sure you want to subscribe for this twunch?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
        [alert release];
    }
}

- (void)subscribe {
//	if ([engine isAuthorized]) {
//		[NSThread detachNewThreadSelector:@selector(setRefreshView) toTarget:self withObject:nil];
//		[engine sendUpdate:[NSString stringWithFormat:@"(%@) @twunch I'll be there! %@", twunch.name, twunch.link]];
//		return;
//	} else {
//		[engine requestRequestToken];
//
//		SA_OAuthTwitterController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:engine delegate:self];
//		if (controller) {
//			[self presentModalViewController:controller animated:YES];
//		} else {
//			[NSThread detachNewThreadSelector:@selector(setRefreshView) toTarget:self withObject:nil];
//			[engine sendUpdate:[NSString stringWithFormat:@"(%@) @twunch I'll be there! %@", twunch.name, twunch.link]];
//		}
//	}
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
