//
//  MCWebViewController.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 13/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCWebViewController.h"

@implementation MCWebViewController

@synthesize participant;

#pragma mark Overridden methods

- (void)loadView {
	[super loadView];
	
	self.title = [NSString stringWithFormat:@"@%@",participant.twitterName];
	
	webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	[self setView:webView];
}

- (void)viewWillAppear:(BOOL)animated {
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.twitter.com/%@", participant.twitterName]]]];
}

@end
