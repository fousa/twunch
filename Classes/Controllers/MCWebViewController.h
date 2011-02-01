//
//  MCWebViewController.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 13/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCParticipant.h"
#import "MCRefreshView.h"

@interface MCWebViewController : UIViewController <UIWebViewDelegate> {
	MCParticipant *participant;
	UIWebView *webView;
	MCRefreshView *refreshView;
}

@property (retain) MCParticipant *participant;

@end
