//
//  MCMapPin.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 11/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MCMapPin : MKPinAnnotationView <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
