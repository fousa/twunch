//
//  MCParticipantsTableViewCell.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCParticipant.h"

@interface MCParticipantsTableViewCell : UITableViewCell {
	MCParticipant *participant;
}

@property (nonatomic, retain) MCParticipant *participant;

@end
