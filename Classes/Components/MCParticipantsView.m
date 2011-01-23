//
//  MCParticipantsView.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 26/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCParticipantsView.h"
#import "MCParticipantWithNameButton.h"
#import "MCParticipant.h"

@implementation MCParticipantsView

@synthesize twunch;
@synthesize controller;

#pragma mark Personal methods

- (id)initWithFrame:(CGRect)frame twunch:(MCTwunch *)myTwunch andController:(id)aController {	
	if (self = [super initWithFrame:frame]) {
		twunch = myTwunch;
		
		CGPoint startPoint = CGPointMake(0, 0);
		CGPoint currentPoint = CGPointMake(0, 0);
		NSEnumerator *participantsEnumerator = [twunch.participants objectEnumerator];
		CGSize participantSize;
		MCParticipant *participant;
		while (participant = [participantsEnumerator nextObject]) {
			participantSize = [MCParticipantWithNameButton sizeForParticipant:participant];
			if ((currentPoint.x + 10 + participantSize.width) > frame.size.width) {
				currentPoint.y = currentPoint.y + participantSize.height + 10;
				currentPoint.x = startPoint.x;
			}
			
			MCParticipantWithNameButton *participantButton = [[MCParticipantWithNameButton alloc] initWithFrame:CGRectMake(currentPoint.x, currentPoint.y, participantSize.width, participantSize.height)];
			participantButton.participant = participant;
			[participantButton addTarget:aController action:@selector(goToWebView:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:participantButton];
			
			currentPoint.x = currentPoint.x + participantSize.width + 10;
		}
	}
	return self;
}

- (void)setTwunch:(MCTwunch *)myTwunch  {
	twunch = myTwunch;
	[self setNeedsDisplay]; 
}


@end
