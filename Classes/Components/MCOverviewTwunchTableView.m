//
//  MCOverviewTwunchTableView.m
//  Twunch
//
//  Created by Simon Schoeters on 15/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCOverviewTwunchTableView.h"

@implementation MCOverviewTwunchTableView

- (void)drawRect:(CGRect)rectangle {
	// Draw background gradient image
	UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
	[backgroundImage drawInRect:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
}

@end
