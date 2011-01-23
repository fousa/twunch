//
//  MCTwunch.h
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MCTwunch : NSObject {
	int index;
	NSString *name;
	NSString *address;
	CLLocation *location;
	NSDate *date;
	NSMutableArray *participants;
}

@property (nonatomic) int index;
@property (retain) NSString *name;
@property (retain) CLLocation *location;
@property (retain) NSString *address;
@property (retain) NSDate *date;
@property (retain) NSMutableArray *participants;
- (BOOL)nearbyTwunch:(CLLocation *)location;

- (NSString *)dateRepresentation;
- (BOOL)pastTwunch;
- (BOOL)nearbyTwunch:(CLLocation *)yourLocation;
- (int)distanceToTwunch:(CLLocation *)yourLocation;	// returns distance in meters, divide by 1000 for km. Returns 9999 when nothing found.
- (BOOL)subscribed:(NSString *)yourTwitterName;

@end
