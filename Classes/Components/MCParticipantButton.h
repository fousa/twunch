//
//  MCParticipantButton.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 12/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"

@interface MCParticipantButton : UIButton {
	MCTwunch *twunch;
}

@property (retain) MCTwunch *twunch;

+ (CGSize)sizeForParticipantsCount:(int)count;

@end
