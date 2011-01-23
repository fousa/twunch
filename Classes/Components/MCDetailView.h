//
//  MCDetailView.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 11/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"

@interface MCDetailView : UIView {
	MCTwunch *twunch;
	NSString *twitterName;
	BOOL subscribed;
	
	id controller;
}

@property (retain) MCTwunch *twunch;
@property (nonatomic) BOOL subscribed;
@property (retain) id controller;

- (id)initWithFrame:(CGRect)frame twunch:(MCTwunch *)myTwunch twitterName:(NSString *)myTwitterName;

@end
