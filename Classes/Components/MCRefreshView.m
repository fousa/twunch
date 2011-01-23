//
//  MCRefreshView.m
//  Kosmonaut
//
//  Created by Jelle Vandebeeck on 21/06/09.
//  Copyright 2009 milkcarton. All rights reserved.
//

#import "MCRefreshView.h"

#define mcRefreshSize 150

@implementation MCRefreshView

@synthesize text;

- (id)initFromView:(UIView *)tableView {
	self = [super initWithFrame:CGRectMake((tableView.frame.size.width - mcRefreshSize) / 2, (tableView.frame.size.height - mcRefreshSize) / 2 - 20, mcRefreshSize, mcRefreshSize)];
	self.backgroundColor = [UIColor clearColor];
	
	UIActivityIndicatorView *progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	progressView.frame = CGRectMake(57.0, 40.0, progressView.bounds.size.width, progressView.bounds.size.height);
	[progressView startAnimating];
	[self addSubview:progressView];
	
	return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextBeginTransparencyLayer(context, NULL);
	
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7] CGColor]);
    
    CGRect rrect = self.bounds;
    
    CGFloat radius = 15.0;
    CGFloat width = CGRectGetWidth(rrect);
    CGFloat height = CGRectGetHeight(rrect);
    
    // Make sure corner radius isn't larger than half the shorter side
    if (radius > width/2.0)
        radius = width/2.0;
    if (radius > height/2.0)
        radius = height/2.0;    
    
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat midy = CGRectGetMidY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
	
	[[UIColor colorWithRed:.859 green:.859 blue:.855 alpha:1.0] set];
	
	[text drawInRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 100, width, height - 100) withFont:[UIFont fontWithName:@"AmericanTypewriter" size:25] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
	
	
	CGContextEndTransparencyLayer(context);
}

#pragma mark Personal methods

- (void)setText:(NSString *)myText {
	text = myText;
	[self setNeedsDisplay];
}

@end
