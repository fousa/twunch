//
//  MCParticipantWithNameButton.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 26/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCParticipant.h"
#import "MCTwunch.h"

@interface MCParticipantWithNameButton : UIButton {
	MCParticipant *participant;
}

@property (retain) MCParticipant *participant;

+ (CGSize)sizeForParticipant:(MCParticipant *)myParticipant;
+ (CGSize)sizeForTwunch:(MCTwunch *)myTwunch;

@end
