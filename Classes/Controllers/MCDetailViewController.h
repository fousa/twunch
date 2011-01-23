//
//  MCDetailViewController.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMapViewController.h"
#import "MCParticipantsViewController.h"
#import "MCTwunch.h"
#import "SA_OAuthTwitterController.h"
#import "MCRefreshView.h"

@class SA_OAuthTwitterEngine;

@interface MCDetailViewController : UITableViewController <SA_OAuthTwitterControllerDelegate> {
	MCMapViewController *mapController;
	MCParticipantsViewController *participantsController;
	
	MCRefreshView *refreshView;
	
	MCTwunch *twunch;
	int headerHeight;
	
	SA_OAuthTwitterEngine *engine;
}

@property (retain) MCMapViewController *mapController;
@property (retain) MCParticipantsViewController *participantsController;
@property (retain) MCTwunch *twunch;

- (void)subscribe;
- (void)reloadData;

@end
