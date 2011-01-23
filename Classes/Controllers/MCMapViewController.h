//
//  MCMapViewController.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTwunch.h"
#import <MapKit/MapKit.h>
#import "MCMapPin.h"

@interface MCMapViewController : UIViewController <MKMapViewDelegate> {
	MCTwunch *twunch;
	MKMapView *mapView;
	MCMapPin *pin;
	BOOL loaded;
}

@property (retain) MCTwunch *twunch;

@end
