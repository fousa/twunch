//
//  MCTwunchTableViewCell.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"

@interface MCTwunchTableViewCell : UITableViewCell {
	MCTwunch *twunch;
	CLLocation *currentLocation;
}

@property (nonatomic, retain) MCTwunch *twunch;
@property (nonatomic, retain) CLLocation *currentLocation;

@end
