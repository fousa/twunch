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

#pragma mark -
#pragma mark Initializers

- (id)init {
	if (!(self = [super init])) return nil;
	
	twunches = [[NSMutableArray array] retain];
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
		[self.locationManager startUpdatingLocation];
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.refreshHeaderView setCurrentDate];
}

- (void)loadView {
	self.title = @"Twunches";
	showNearbyTwunches = YES;
	locationFound = NO;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:.373 green:.208 blue:.09 alpha:1.0];
	
	UIBarButtonItem *locateButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"locate.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showNearbyTwunchesAction)];
	locateButton.tag = 2001;
	self.navigationItem.leftBarButtonItem = locateButton;
	self.navigationItem.leftBarButtonItem.enabled = NO;
	[locateButton release];
	
	[super loadView];
	
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
		twunchCell = [[[MCTwunchTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
        twunchCell.accessoryType = UITableViewCellAccessoryNone;
        twunchCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	twunchCell.twunch = twunch;
	twunchCell.currentLocation = currentLocation;
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
	
	MCTwunchLoader *loader = [[MCTwunchLoader alloc] init];
	loader.delegate = self;
	loader.selector = @selector(refreshTableWithTwunches:);
	[loader loadXML];
}

- (void)fillTableWithTwunches:(NSMutableArray *)loadedTwunches {
	twunches = loadedTwunches;
	allTwunches = [loadedTwunches copy];
	[self.tableView reloadData];
}

- (void)refreshTableWithTwunches:(NSMutableArray *)loadedTwunches {
	twunches = loadedTwunches;
	allTwunches = [loadedTwunches copy];
	[self.tableView reloadData];
	[self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 100) animated:YES];
	[[self.tableView.window viewWithTag:1000] removeFromSuperview];
	[self.locationManager startUpdatingLocation];
	
	[self performSelectorOnMainThread:@selector(dataSourceDidFinishLoadingNewData) withObject:nil waitUntilDone:NO];
}

- (void)showNearbyTwunchesAction {
	[twunches removeAllObjects];
	for (MCTwunch *twunch in allTwunches) {
		if (!showNearbyTwunches || [twunch nearbyTwunch:currentLocation]) {
			[twunches addObject:twunch];
		}
	}
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
	showNearbyTwunches = !showNearbyTwunches;
	self.navigationItem.leftBarButtonItem.style = showNearbyTwunches ? UIBarButtonItemStylePlain : UIBarButtonItemStyleDone;
}

- (void)reloadTableViewDataSource{
	[self performSelectorInBackground:@selector(refreshTwunches) withObject:nil];
}
- (void)dataSourceDidFinishLoadingNewData{
	[refreshHeaderView setCurrentDate];
	
	[super dataSourceDidFinishLoadingNewData];
}

@end
