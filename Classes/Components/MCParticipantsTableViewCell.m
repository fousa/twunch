//
//  MCParticipantsTableViewCell.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCParticipantsTableViewCell.h"

@implementation MCParticipantsTableViewCell

@synthesize participant;

static UIFont *nameFont = nil;

+ (void)initialize {
	if (self == [MCParticipantsTableViewCell class]) {
		nameFont = [[UIFont boldSystemFontOfSize:18] retain];
	}
}

- (void)drawRect:(CGRect)rectangle {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *backgroundImage = [UIImage imageNamed:@"cell-background.png"];
	
	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *nameColor = [UIColor blackColor];
	
	if (self.selected) {
		backgroundColor = [UIColor clearColor];
		nameColor = [UIColor whiteColor];
		backgroundImage = nil;
	}
	CGPoint point = CGPointMake(1, 2);
	
	// Set background
	[backgroundColor set];
	CGContextFillRect(context, rectangle);
	
	// Draw background gradient image
	[backgroundImage drawInRect:CGRectMake(point.x, point.y + 39, 320, 10)];
	
	// Draw name
	[nameColor set];
	point.x += 10;
	point.y += 12;
	[[NSString stringWithFormat:@"@%@", participant.twitterName] drawAtPoint:point forWidth:230 withFont:nameFont lineBreakMode:UILineBreakModeTailTruncation];
}

- (void)setParticipant:(MCParticipant *)myParticipant  {
	participant = myParticipant;
	[self setNeedsDisplay]; 
}

@end
