//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor whiteColor]

@implementation EGORefreshTableHeaderView

@synthesize state=_state;
@synthesize bottomBorderThickness;
@synthesize bottomBorderColor;

static NSDateFormatter *refreshFormatter;


+ (void)initialize
{
  /* Formatter for last refresh date */
  refreshFormatter = [[NSDateFormatter alloc] init];
  [refreshFormatter setDateStyle:NSDateFormatterShortStyle];
  [refreshFormatter setTimeStyle:NSDateFormatterShortStyle];
}


// Sets up the frame following the recipe in the samples except it doesn't *overlap* the partner view,
// ensuring that if you choose to draw a bottom border (by setting bottomBorderThickness > 0.0) then
// you'll get a proper border, not a partially obscured one.
- (id)initWithFrameRelativeToFrame:(CGRect)originalFrame {
	CGRect relativeFrame = CGRectMake(0.0f, 0.0f - originalFrame.size.height, originalFrame.size.width, originalFrame.size.height);
	[self setBottomBorderThickness:1.0f];
	return [self initWithFrame:relativeFrame];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
		lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, frame.size.height - 30.0f, self.frame.size.width - 40.0f, 20.0f)];
		lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		lastUpdatedLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
		lastUpdatedLabel.textColor = TEXT_COLOR;
		lastUpdatedLabel.shadowColor = [UIColor grayColor];
		lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:lastUpdatedLabel];
		[lastUpdatedLabel release];
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, frame.size.height - 48.0f, self.frame.size.width - 40.0f, 20.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
		statusLabel.textColor = TEXT_COLOR;
		statusLabel.shadowColor = [UIColor grayColor];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textAlignment = UITextAlignmentCenter;
		
		[self setState:EGOOPullRefreshNormal];
		[self addSubview:statusLabel];
		[statusLabel release];
		
		arrowImage = [[CALayer alloc] init];
		arrowImage.frame = CGRectMake(15.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		arrowImage.contentsGravity = kCAGravityResizeAspect;
		arrowImage.contents = (id)[UIImage imageNamed:@"whiteArrow.png"].CGImage;
		[[self layer] addSublayer:arrowImage];
		[arrowImage release];
		
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		activityView.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		[activityView release];
		
    }
    return self;
}

- (void)setLastRefreshDate:(NSDate*)date
{
  if (!date) {
    [lastUpdatedLabel setText:NSLocalizedString(@"Never Updated", @"No Last Update Date text")];
    return;
  }
  
	lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [refreshFormatter stringFromDate:date]];
}

- (void)setCurrentDate {
	lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [refreshFormatter stringFromDate:[NSDate date]]];
}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			
			statusLabel.text = @"Release to refresh...";
			[CATransaction begin];
			[CATransaction setAnimationDuration:.18];
			arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:.18];
				arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			statusLabel.text = @"Pull down to refresh...";
			[activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			arrowImage.hidden = NO;
			arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshLoading:
			
			statusLabel.text = @"Loading...";
			[activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshUpToDate:
        
			statusLabel.text = @"Up-to-date.";
			[activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}

- (void)dealloc {
	[bottomBorderColor release], bottomBorderColor = nil;
	activityView = nil;
	statusLabel = nil;
	arrowImage = nil;
	lastUpdatedLabel = nil;
    [super dealloc];
}


@end
