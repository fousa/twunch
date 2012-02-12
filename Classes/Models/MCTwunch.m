//
//  MCTwunch.m
//  Twunch
//
//  Created by Jelle Vandebeeck on 04/08/09.
//  Creative commons milkcarton 2009. Some rights reserved.
//

#import "MCTwunch.h"
#import "MCParticipant.h"

@implementation MCTwunch

@synthesize index;
@synthesize name;
@synthesize link;
@synthesize location;
@synthesize address;
@synthesize date;
@synthesize participants;
@synthesize closed;

- (NSString *)dateRepresentation {
	if (date == nil) {
		return @"";
	}
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSString *dateRepresentation = @"";
	[formatter setDateFormat:@"dd "];
	dateRepresentation = [dateRepresentation stringByAppendingString:[formatter stringFromDate:date]];

	[formatter setDateFormat:@"M"];
	switch ([[formatter stringFromDate:date] intValue]) {
		case 1:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"JAN"];
			break;
		case 2:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"FEB"];
			break;
		case 3:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"MRT"];
			break;
		case 4:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"APR"];
			break;
		case 5:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"MEI"];
			break;
		case 6:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"JUN"];
			break;
		case 7:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"JUL"];
			break;
		case 8:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"AUG"];
			break;
		case 9:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"SEP"];
			break;
		case 10:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"OKT"];
			break;
		case 11:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"NOV"];
			break;
		case 12:
			dateRepresentation = [dateRepresentation stringByAppendingString:@"DEC"];
			break;
		default:
			break;
	}
	[formatter setDateFormat:@" @ HH:mm"];
	return [dateRepresentation stringByAppendingString:[formatter stringFromDate:date]];
}

- (BOOL)pastTwunch {
	NSUInteger desiredComponents = NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	NSDate *twunchDate = [[NSCalendar currentCalendar] dateFromComponents:[[NSCalendar currentCalendar] components:desiredComponents fromDate:date]];
	NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:[[NSCalendar currentCalendar] components:desiredComponents fromDate:[NSDate date]]];
	NSComparisonResult result = [today compare:twunchDate];
	return result == NSOrderedDescending;
}

- (BOOL)nearbyTwunch:(CLLocation *)yourLocation {
	if (location == nil || yourLocation == nil) {
		return NO;
	}
	return [yourLocation distanceFromLocation:location] < 60000;
}

- (int)distanceToTwunch:(CLLocation *)yourLocation {
	if (location == nil || yourLocation == nil) {
		return -1;
	}
	return [yourLocation distanceFromLocation:location];
}

- (BOOL)subscribed:(NSString *)yourTwitterName {
    if (yourTwitterName == nil) return NO;
    
	NSEnumerator *participantsEnumerator = [participants objectEnumerator];
	MCParticipant *participant;
	while (participant = [participantsEnumerator nextObject]) {
		if ([yourTwitterName compare:participant.twitterName] == NSOrderedSame) {
			return YES;
		}
	}
	return NO;
}

@end
