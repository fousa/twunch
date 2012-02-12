//
//  MCParticipantsView.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 26/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"

@interface MCParticipantsView : UIView {
	MCTwunch *twunch;
	
	id controller;
}

@property (nonatomic, retain) MCTwunch *twunch;
@property (nonatomic, retain) id controller;

- (id)initWithFrame:(CGRect)frame twunch:(MCTwunch *)myTwunch andController:(id)controller;
@end
