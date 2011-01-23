//
//  MCSubscribeButton.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 12/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCSubscribeButton.h"

@implementation MCSubscribeButton

@synthesize selected;

#pragma mark Overridden methods

- (void)drawRect:(CGRect)rectangle {
	UIImage *image;
	if (selected) {
		image = [UIImage imageNamed:@"detail-subscribed.png"];
	} else {
		image = [UIImage imageNamed:@"detail-subscribe.png"];
	}
	[image drawInRect:rectangle];
}

@end
