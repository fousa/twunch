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
	
	webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	webView.delegate = self;
	[self setView:webView];
	
	refreshView = [[MCRefreshView alloc] initFromView:self.view];
	refreshView.text = @"Loading";
	refreshView.tag = 1001;
}

- (void)viewWillAppear:(BOOL)animated {
	self.title = [NSString stringWithFormat:@"@%@",participant.twitterName];
	
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.twitter.com/%@", participant.twitterName]]]];
}

- (void)viewDidAppear:(BOOL)animated {
	[NSThread detachNewThreadSelector:@selector(setRefreshView) toTarget:self withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[[self.view.window viewWithTag:1001] removeFromSuperview];
}

- (void)setRefreshView {
	self.navigationItem.leftBarButtonItem.enabled = NO;
	[self.view.window addSubview:refreshView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[self.view.window viewWithTag:1001] removeFromSuperview];
}

@end
