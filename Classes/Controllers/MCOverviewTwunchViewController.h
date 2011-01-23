//
//  MCOverviewTwunchViewController.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDetailViewController.h"
#import "SA_OAuthTwitterController.h"
#import "MCRefreshView.h"

@class SA_OAuthTwitterEngine;

@interface MCOverviewTwunchViewController : UITableViewController <CLLocationManagerDelegate> {
	MCDetailViewController *detailController;
	MCRefreshView *refreshView;
	
	NSMutableArray *twunches;
	NSMutableArray *allTwunches;
	
	CLLocationManager *locationManager;
	CLLocation *currentLocation;
	
	BOOL locationFound;
	BOOL showNearbyTwunches;
}

@property (retain) MCDetailViewController *detailController;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
