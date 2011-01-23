//
//  MCParticipantButton.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 12/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCParticipantButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MCParticipantButton

@synthesize twunch;

#pragma mark Overridden methods

- (void)drawRect:(CGRect)rectangle {
	CGPoint startPoint = CGPointMake(0, 0);
	CGPoint currentPoint = CGPointMake(0, 0);
	for (int i = 0; i < [twunch.participants count]; i++) {
		if (i >= 29) {
			if (self.highlighted) {
				[[UIImage imageNamed:@"detail-more-participants-highlighted.png"] drawInRect:CGRectMake(currentPoint.x, currentPoint.y, 40, 30)];
			} else {
				[[UIImage imageNamed:@"detail-more-participants.png"] drawInRect:CGRectMake(currentPoint.x, currentPoint.y, 40, 30)];
			}
			break;
		}
		
		if (self.highlighted) {
			[[UIImage imageNamed:@"detail-participant-highlighted.png"] drawInRect:CGRectMake(currentPoint.x, currentPoint.y, 40, 30)];
		} else {
			[[UIImage imageNamed:@"detail-participant.png"] drawInRect:CGRectMake(currentPoint.x, currentPoint.y, 40, 30)];
		}
		
		if ((currentPoint.x + 10 + 40) > rectangle.size.width) {
			currentPoint.y = currentPoint.y + 30 + 10;
			currentPoint.x = startPoint.x;
		} else {
			currentPoint.x = currentPoint.x + 40 + 10;
		}
	}
}

- (void)setTwunch:(MCTwunch *)myTwunch  {
	twunch = myTwunch;
	[self setNeedsDisplay]; 
}

#pragma mark Delegate methods for UIButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	[self setNeedsDisplay];
}

#pragma mark Personal methods

+ (CGSize)sizeForParticipantsCount:(int)count {
	int rows = count / 6;
	if ((count % 6) > 0) {
		rows += 1;
	}
	if (rows > 5) {
		rows = 5;
	}
	
	float width;
	if (count > 6) {
		width = (40 * 6) + (10 * 5);
	} else {
		width = (40 * count) + (10 * (count -1));
	}
	float height = (30 * rows) + (10 * (rows - 1));
	
	return CGSizeMake(width, height);
}

@end
