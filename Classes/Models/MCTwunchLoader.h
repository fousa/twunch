//
//  MCTwunchLoader.h
//  XML
//
//  Created by Simon Schoeters on 09/08/09.
//  Copyright 2009 IMEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCTwunch.h"


@interface MCTwunchLoader : NSObject <NSXMLParserDelegate> {
	NSMutableArray *twunches;
	NSMutableArray *participants;
	MCTwunch *currentTwunch;
	NSMutableString *currentStringValue;
	BOOL showTwunch;
	int currentIndex;
	
	float latitude;
	float longitude;

	id delegate;
	SEL selector;
}

- (void)loadXML;

@property (retain) id delegate;
@property (nonatomic) SEL selector;

@end
