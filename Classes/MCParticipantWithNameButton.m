//
//  MCParticipantWithNameButton.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 26/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCParticipantWithNameButton.h"

@implementation MCParticipantWithNameButton

@synthesize participant;

static UIFont *nameFont = nil;
static UIColor *grayColor = nil;

+ (void)initialize {
	if (self == [MCParticipantWithNameButton class]) {
		nameFont = [[UIFont fontWithName:@"AmericanTypewriter" size:20] retain];
		grayColor = [[UIColor colorWithRed:.859 green:.859 blue:.855 alpha:1.0] retain];
	}
}

#pragma mark Overridden methods

- (void)drawRect:(CGRect)rectangle {
	[grayColor set];	
	[participant.twitterName drawAtPoint:CGPointMake(50, 10) withFont:nameFont];
	[[UIImage imageNamed:@"detail-participant-highlighted.png"] drawInRect:CGRectMake(5, 5, 40.0f, 30.0f)];
}

#pragma mark Personal methods

- (void)setParticipant:(MCParticipant *)myParticipant  {
	participant = myParticipant;
	[self setNeedsDisplay]; 
}

+ (CGSize)sizeForParticipant:(MCParticipant *)myParticipant {
	CGSize size = [myParticipant.twitterName sizeWithFont:nameFont];
	size.width = size.width + 60;
	size.height = 40;
	return size;
}

+ (CGSize)sizeForTwunch:(MCTwunch *)twunch {
	NSEnumerator *participantsEnumerator = [twunch.participants objectEnumerator];
	CGSize participantSize;
	CGPoint startPoint = CGPointMake(0, 0);
	CGPoint currentPoint = CGPointMake(0, 0);
	MCParticipant *participant;
	while (participant = [participantsEnumerator nextObject]) {
		participantSize = [MCParticipantWithNameButton sizeForParticipant:participant];
		if ((currentPoint.x + 10 + participantSize.width) > 320) {
			currentPoint.y = currentPoint.y + participantSize.height + 10;
			currentPoint.x = startPoint.x;
		}
		currentPoint.x = currentPoint.x + participantSize.width + 10;
	}
	
	return CGSizeMake(320, currentPoint.y + participantSize.height + 10);
}

@end
