//
//  MCTwunchTableViewCell.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCTwunchTableViewCell.h"

@implementation MCTwunchTableViewCell

@synthesize twunch;
@synthesize currentLocation;

static UIFont *nameFont = nil;
static UIFont *dateFont = nil;

+ (void)initialize {
	if (self == [MCTwunchTableViewCell class]) {
		nameFont = [[UIFont fontWithName:@"AmericanTypewriter" size:20] retain];
		dateFont = [[UIFont fontWithName:@"AmericanTypewriter" size:14] retain];		
	}
}

- (void)drawRect:(CGRect)rectangle {
	UIImage *backgroundImage;
	if (self.highlighted) {
		backgroundImage = [UIImage imageNamed:@"overview-cell-right-highlighted.png"];
	} else {
		backgroundImage = [UIImage imageNamed:@"overview-cell-right.png"];
	}
	[backgroundImage drawInRect:CGRectMake(70, 0, 250, 60)];
	
	// Draw name
	[[UIColor colorWithRed:.941 green:.333 blue:.157 alpha:1.0] set];
	[twunch.name drawAtPoint:CGPointMake(70, 10) forWidth:200 withFont:nameFont lineBreakMode:UILineBreakModeTailTruncation];
	
	// Draw date
	[[UIColor colorWithRed:.859 green:.859 blue:.855 alpha:1.0] set];
	[[twunch dateRepresentation] drawAtPoint:CGPointMake(70, 35) forWidth:210 withFont:dateFont lineBreakMode:UILineBreakModeTailTruncation];
	
	// Draw distance or cutlery icon
	UIImage *iconImage;
	int distanceToTwunch = [twunch distanceToTwunch:currentLocation];
	if (distanceToTwunch >= 0) {
		distanceToTwunch = distanceToTwunch / 1000;
	}
	NSString *iconName = @"overview-cell-left-";
	if (distanceToTwunch < 1 && distanceToTwunch >=0) {
		iconName = [iconName stringByAppendingString:@"0"];
	} else if (distanceToTwunch >= 1 && distanceToTwunch <= 50) {
		iconName = [NSString stringWithFormat:@"%@%i",iconName,distanceToTwunch];
	} else {
		iconName = [iconName stringByAppendingString:@"cutlery"];
	}
	if (self.highlighted) { 
		iconName = [iconName stringByAppendingString:@"-highlighted"];
	}
	iconName = [iconName stringByAppendingString:@".png"];
	iconImage = [UIImage imageNamed:iconName];	
	[iconImage drawInRect:CGRectMake(0, 0, 70, 60)];
}

- (void)setTwunch:(MCTwunch *)myTwunch  {
	twunch = myTwunch;
	[self setNeedsDisplay]; 
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	[self setNeedsDisplay]; 	
}

@end
