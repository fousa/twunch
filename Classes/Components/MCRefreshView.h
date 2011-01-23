//
//  MCRefreshView.h
//  Kosmonaut
//
//  Created by Jelle Vandebeeck on 21/06/09.
//  Copyright 2009 milkcarton. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCRefreshView : UIView {
	NSString *text;
}

@property (retain) NSString *text;

- (id)initFromView:(UIView *)tableView;

@end
