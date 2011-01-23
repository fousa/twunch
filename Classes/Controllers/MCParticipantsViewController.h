//
//  MCParticipantsController.h
//  Twunch
//
//  Created by Simon Schoeters on 20/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"
#import "MCWebViewController.h"

@interface MCParticipantsViewController : UITableViewController {
	MCWebViewController *webController;
}

@property (retain) MCTwunch *twunch;
@property (retain) MCWebViewController *webController;

@end
