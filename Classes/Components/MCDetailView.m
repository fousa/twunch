//
//  MCDetailView.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 11/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCDetailView.h"
#import "MCSubscribeButton.h"
#import "MCParticipantButton.h"

@implementation MCDetailView

@synthesize twunch;
@synthesize controller;
@synthesize subscribed;

static UIFont *dateFont = nil;
static UIFont *titleFont = nil;
static UIFont *addressFont = nil;
static UIColor *orangeColor = nil;
static UIColor *grayColor = nil;

+ (void)initialize {
	if (self == [MCDetailView class]) {
		dateFont = [[UIFont fontWithName:@"AmericanTypewriter" size:24] retain];		
		titleFont = [[UIFont fontWithName:@"AmericanTypewriter" size:26] retain];
		addressFont = [[UIFont fontWithName:@"AmericanTypewriter" size:16] retain];	
		orangeColor = [UIColor colorWithRed:.941 green:.333 blue:.157 alpha:1.0];
		grayColor = [UIColor colorWithRed:.859 green:.859 blue:.855 alpha:1.0];
	}
}

#pragma mark Overridden methods

- (void)drawRect:(CGRect)rectangle {
	// Draw date
	UIImage *dateImage = [UIImage imageNamed:@"detail-date.png"];
	[dateImage drawInRect:CGRectMake(0, 346, 320, 50)];
	[orangeColor set];
	[[twunch dateRepresentation] drawAtPoint:CGPointMake(30, 356) forWidth:190 withFont:dateFont lineBreakMode:UILineBreakModeTailTruncation];
}	

#pragma mark Personal methods

- (id)initWithFrame:(CGRect)frame twunch:(MCTwunch *)myTwunch twitterName:(NSString *)myTwitterName {	
    if (self = [super initWithFrame:frame]) {
		twunch = myTwunch;
		
		// Subscribe button
		MCSubscribeButton *subscriberButton = [[MCSubscribeButton alloc] initWithFrame:CGRectMake(230, 336, 80, 80)];
		BOOL participating = [twunch subscribed:myTwitterName];
		subscriberButton.selected = participating;
		subscriberButton.enabled = !participating;
		[subscriberButton addTarget:controller action:@selector(subscribeWithAlert) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:subscriberButton];
		
		// Title and address button
		UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 16, 320, 100)];
		[mapButton setBackgroundImage:[UIImage imageNamed:@"detail-address.png"] forState:UIControlStateNormal];
		[mapButton setBackgroundImage:[UIImage imageNamed:@"detail-address-highlighted.png"] forState:UIControlStateHighlighted];
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 220, 30)];
		titleLabel.text = myTwunch.name;
		titleLabel.textColor = orangeColor;
		titleLabel.font = titleFont;
		titleLabel.adjustsFontSizeToFitWidth = YES;
		titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
		titleLabel.minimumFontSize = 18;
		titleLabel.backgroundColor = [UIColor clearColor];
		[mapButton addSubview:titleLabel];
		
		UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 220, 40)];
		addressLabel.text = myTwunch.address;
		addressLabel.textColor = grayColor;
		addressLabel.font = addressFont;
		addressLabel.numberOfLines = 2;
		addressLabel.backgroundColor = [UIColor clearColor];
		[mapButton addSubview:addressLabel];

		[mapButton addTarget:controller action:@selector(goToMapView) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:mapButton];
	
		// Participants button
		int count = [twunch.participants count];
		CGSize participantButtonSize = [MCParticipantButton sizeForParticipantsCount:count];
		
		MCParticipantButton *participantButton = [[MCParticipantButton alloc] initWithFrame:CGRectMake(10, 136, participantButtonSize.width, participantButtonSize.height)];
		participantButton.twunch = twunch;
		participantButton.backgroundColor = [UIColor clearColor];
		
		[participantButton addTarget:controller action:@selector(goToParticipantsView) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:participantButton];
	}
	return self;
}

- (void)setTwunch:(MCTwunch *)myTwunch  {
	twunch = myTwunch;
	[self setNeedsDisplay]; 
}

@end
