//
//  MCTwunchLoader.m
//  XML
//
//  Created by Simon Schoeters on 09/08/09.
//  Copyright 2009 IMEC. All rights reserved.
//

#import "MCTwunchLoader.h"
#import "MCParticipant.h"

#define RSSURL @"http://twunch.be/events.xml?when=future"
#define BASEURL @"http://twunch.be"

@implementation MCTwunchLoader

@synthesize delegate;
@synthesize selector;

- (void)loadXML {
	NSURL *url = [NSURL URLWithString:RSSURL];
	NSData *data = [NSData dataWithContentsOfURL:url];
	currentIndex = 0;
	
	if (data == nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection problem" message:@"No internet connection." delegate:nil cancelButtonTitle:@"Continue" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
		[parser setDelegate:self];
		[parser setShouldProcessNamespaces:NO];
		[parser setShouldReportNamespacePrefixes:NO];
		[parser setShouldResolveExternalEntities:NO];
		[parser parse];
		
		[parser release];
	}
}

- (void)dealloc {
	[currentTwunch release];
	[participants release];
	[twunches release];
	[super dealloc];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqualToString:@"twunches"]) {
		if(!twunches) {
			twunches = [NSMutableArray array];
		}
		return;
	}
	
	if([elementName isEqualToString:@"twunch"]) {
		if (!currentTwunch) {
			currentTwunch = [[MCTwunch alloc] init];
			currentTwunch.index = currentIndex++;
			//showTwunch = YES;
		}
		return;
	}
	
	if([elementName isEqualToString:@"participants"]) {
		participants = [NSMutableArray array];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"title"]) {
		NSString *title = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		currentTwunch.name = title;
	}
	
	if([elementName isEqualToString:@"address"]) {
		NSString *address = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		currentTwunch.address = address;
	}
	
	if([elementName isEqualToString:@"id"]) {
		NSString *givenDate = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		NSString *dateFromString = [givenDate substringFromIndex:([givenDate length] - 13)];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyyMMdd-HHmm"];
		currentTwunch.date = [formatter dateFromString:dateFromString];
		
		//if([currentTwunch pastTwunch]) {
		//	showTwunch = NO;
		//}
	}
	
	if([elementName isEqualToString:@"latitude"]) {
		NSString *latitudeText = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		latitude = [latitudeText floatValue];
	}
	
	if([elementName isEqualToString:@"longitude"]) {
		NSString *longitudeText = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		longitude = [longitudeText floatValue];
		if (latitude > 0 && longitude > 0) {
			currentTwunch.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		}
	}
	
	if([elementName isEqualToString:@"participant"]) {
		NSString *participantText = [currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		MCParticipant *participant = [[MCParticipant alloc] init];
		participant.twitterName = participantText;
		[participants addObject:participant];
	}
	
	if([elementName isEqualToString:@"participants"]) {
		currentTwunch.participants = participants;
	}
	
	if([elementName isEqualToString:@"twunch"]) {		
		//if (showTwunch) {
		[twunches addObject:currentTwunch];
		//}
		[currentTwunch release];
		currentTwunch = nil;
		latitude = 0;
		longitude = 0;
		return;
	}
	
	[currentStringValue release];
	currentStringValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(!currentStringValue) {
		currentStringValue = [[NSMutableString alloc] init];
	}
	[currentStringValue appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	[delegate performSelector:selector withObject:[twunches retain]];
}

@end