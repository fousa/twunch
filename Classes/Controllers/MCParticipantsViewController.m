//
//  MCParticipantsController.m
//  Twunch
//
//  Created by Simon Schoeters on 20/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCParticipantsViewController.h"
#import "MCOverviewTwunchTableView.h"
#import "MCParticipantsView.h"
#import "MCParticipantWithNameButton.h"

@implementation MCParticipantsViewController

@synthesize twunch;
@synthesize webController;

#pragma mark Overridden methods

- (void)loadView {
	[super loadView];
	self.title = @"Participants";
	
	MCOverviewTwunchTableView *tableView = [[MCOverviewTwunchTableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
	[tableView release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

#pragma mark Delegation methods for the UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return [MCParticipantWithNameButton sizeForTwunch:self.twunch].height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	CGRect rect = CGRectZero;
	rect.size = [MCParticipantWithNameButton sizeForTwunch:self.twunch];
	MCParticipantsView *headerView = [[[MCParticipantsView alloc] initWithFrame:rect twunch:self.twunch andController:self] autorelease];
	headerView.backgroundColor = [UIColor clearColor];
	
	return headerView;
}

#pragma mark Personal methods

- (void)goToWebView:(id)sender {
	webController.participant = ((MCParticipantWithNameButton *) sender).participant;
	[self.navigationController pushViewController:webController animated:YES];
}

@end
