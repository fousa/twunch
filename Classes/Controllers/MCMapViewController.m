//
//  MCMapViewController.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCMapViewController.h"

@implementation MCMapViewController

@synthesize twunch;

#pragma mark Overridden methods

- (void)loadView {
	[super loadView];
	self.title = @"Location";
}

- (void)viewWillAppear:(BOOL)animated {
	mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	mapView.showsUserLocation = YES;
	mapView.delegate = self;
	[self setView:mapView];
	
	MKCoordinateRegion region;
	MKCoordinateSpan span = MKCoordinateSpanMake(0.004, 0.004);
	region.span = span;
	region.center = twunch.location.coordinate;
	
	[mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
	
	pin = [[MCMapPin alloc] init];
	loaded = NO;
	pin.coordinate = twunch.location.coordinate;
	pin.title = twunch.name;
	pin.subtitle = twunch.address;
	[mapView addAnnotation:pin];
}

- (void)viewDidAppear:(BOOL)animated {
	if (loaded) {
		[mapView selectAnnotation:pin animated:YES];
	} else {
		loaded = YES;
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[mapView removeAnnotation:pin];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)myMapView {
	if (loaded) {
		[mapView selectAnnotation:pin animated:YES];
	} else {
		loaded = YES;
	}
}

@end
