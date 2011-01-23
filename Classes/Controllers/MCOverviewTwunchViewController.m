//
//  MCOverviewTwunchViewController.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCOverviewTwunchViewController.h"
#import "MCTwunch.h"
#import "MCParticipant.h"
#import "MCTwunchTableViewCell.h"
#import <MapKit/MapKit.h>
#import "MCOverviewTwunchTableView.h"
#import "MCTwunchLoader.h"
#import <CoreLocation/CoreLocation.h>

@implementation MCOverviewTwunchViewController

@synthesize detailController;
@synthesize locationManager;

#pragma mark Overridden methods

- (void)loadView {
	self.title = @"Twunches";	
	showNearbyTwunches = YES;
	locationFound = NO;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:.373 green:.208 blue:.09 alpha:1.0];
	
	/*UIImageView *navigationBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	[navigationBarImageView setImage:[UIImage imageNamed:@"background.png"]];
	[self.navigationController.navigationBar insertSubview:navigationBarImageView atIndex:0];
	[navigationBarImageView release];*/
	
	// Add refresh button
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTwunches)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
	
	//UIBarButtonItem *localizeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showNearbyTwunchesAction)];
	// TODO Maybe we can use initWithImage:style:target:action: for a custom image?
	UIBarButtonItem *localizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Nearby" style:UIBarButtonItemStylePlain target:self action:@selector(showNearbyTwunchesAction)];
	self.navigationItem.leftBarButtonItem = localizeButton;
	self.navigationItem.leftBarButtonItem.enabled = NO;
	[localizeButton release];

	[super loadView];
	
	refreshView = [[MCRefreshView alloc] initFromView:self.tableView];
	refreshView.text = @"Updating";
	refreshView.tag = 1000;
	
	MCOverviewTwunchTableView *tableView = [[MCOverviewTwunchTableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
	[tableView release];
	
	UIView *containerView =	[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    self.tableView.tableHeaderView = containerView;
	
	MCTwunchLoader *loader = [[MCTwunchLoader alloc] init];
	loader.delegate = self;
	loader.selector = @selector(fillTableWithTwunches:);
	[loader loadXML];
}

- (void)viewDidLoad {
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
		[self.locationManager startUpdatingLocation];
	}
}

#pragma mark Delegation methods for the UITableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [twunches count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MCTwunch *twunch = [twunches objectAtIndex:indexPath.row];
	detailController.twunch = twunch;
	[self.detailController reloadData];
	[self.navigationController pushViewController:self.detailController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"TwunchCell";
	
	MCTwunch *twunch = [twunches objectAtIndex:indexPath.row];
	MCTwunchTableViewCell *twunchCell = (MCTwunchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (twunchCell == nil) {
		twunchCell = [[[MCTwunchTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
	}
	
	twunchCell.twunch = twunch;
	twunchCell.currentLocation = currentLocation;
	twunchCell.accessoryType = UITableViewCellAccessoryNone;
	twunchCell.selectionStyle = UITableViewCellSelectionStyleNone;
	return twunchCell;
}

#pragma mark CLLocationManagerDelegate methods

- (void)locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[manager stopUpdatingLocation];
	currentLocation = [newLocation retain];
	locationFound = YES;
	self.navigationItem.leftBarButtonItem.enabled = YES;
	[self.tableView reloadData];
}

- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
	locationFound = NO;
}

#pragma mark Personal methods

- (void)refreshTwunches {
	showNearbyTwunches = YES;
	locationFound = NO;
	[NSThread detachNewThreadSelector:@selector(setRefreshView) toTarget:self withObject:nil];
	
	MCTwunchLoader *loader = [[MCTwunchLoader alloc] init];
	loader.delegate = self;
	loader.selector = @selector(refreshTableWithTwunches:);
	[loader loadXML];
}

- (void)fillTableWithTwunches:(NSMutableArray *)loadedTwunches {
	twunches = loadedTwunches;
	allTwunches = loadedTwunches;
	[self.tableView reloadData];
}

- (void)refreshTableWithTwunches:(NSMutableArray *)loadedTwunches {
	twunches = loadedTwunches;
	allTwunches = loadedTwunches;
	[self.tableView reloadData];
	[self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 100) animated:YES];
	[[self.tableView.window viewWithTag:1000] removeFromSuperview];
	[self.locationManager startUpdatingLocation];
}

- (void)setRefreshView {
	self.navigationItem.leftBarButtonItem.enabled = NO;
	[self.tableView.window addSubview:refreshView];
}

- (void)showNearbyTwunchesAction {
	if (showNearbyTwunches) {
		NSMutableArray *pastTwunchesIndexes = [NSMutableArray array];
		NSEnumerator *twunchEnumerator = [allTwunches objectEnumerator];
		NSMutableArray *newTwunchArray = [NSMutableArray array];
		MCTwunch *twunch;
		while (twunch = [twunchEnumerator nextObject]) {
			if (![twunch nearbyTwunch:currentLocation]) {
				[pastTwunchesIndexes addObject:[NSIndexPath indexPathForRow:[twunches indexOfObject:twunch] inSection:0]];
			} else {
				[newTwunchArray addObject:twunch];
			}
		}
		[self.tableView beginUpdates];
		twunches = [newTwunchArray retain];
		[self.tableView deleteRowsAtIndexPaths:pastTwunchesIndexes withRowAnimation:UITableViewRowAnimationFade];
		[self.tableView endUpdates];
		showNearbyTwunches = NO;
	} else {
		NSMutableArray *pastTwunchesIndexes = [NSMutableArray array];
		NSEnumerator *twunchEnumerator = [allTwunches objectEnumerator];
		[self.tableView beginUpdates];
		MCTwunch *twunch;
		while (twunch = [twunchEnumerator nextObject]) {
			if (![twunch nearbyTwunch:currentLocation]) {
				[twunches insertObject:twunch atIndex:twunch.index];
				[pastTwunchesIndexes addObject:[NSIndexPath indexPathForRow:twunch.index inSection:0]];
			}
		}
		[self.tableView insertRowsAtIndexPaths:pastTwunchesIndexes withRowAnimation:UITableViewRowAnimationFade];
		[self.tableView endUpdates];
		showNearbyTwunches = YES;
	}
}

@end
