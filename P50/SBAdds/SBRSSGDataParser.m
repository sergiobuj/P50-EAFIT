//
//  SBRSSGDataParser.m
//  P50
//
//  Created by Sergio Botero on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SBRSSGDataParser.h"
#import "GDataXMLNode.h"

static NSString * TITLE = @"title";
static NSString * DESCR = @"description";
static NSString * LINK = @"link";


@implementation SBRSSGDataParser

+ (void) parseRSS:(NSString *) rssurl withDelegate:(id) delegate{

	NSMutableArray * responseArray = [[[NSMutableArray alloc] init] autorelease];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	GDataXMLDocument * docu = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:rssurl]] options:0 error:nil];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSArray *items = [docu nodesForXPath:@"//item" error:nil];
    for (GDataXMLElement *item in items) {
		NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

		[dict setObject:[[[item elementsForName:TITLE] objectAtIndex:0] stringValue] forKey:TITLE];
		[dict setObject:[[[item elementsForName:DESCR] objectAtIndex:0] stringValue] forKey:DESCR];
		[dict setObject:[[[item elementsForName:LINK] objectAtIndex:0] stringValue] forKey:LINK];
		[responseArray addObject:dict];
		
		[dict release];
	}
	
	if ([delegate respondsToSelector:@selector(responseArray:)]) {
		[ (id)delegate performSelectorOnMainThread:@selector(responseArray:) withObject:responseArray waitUntilDone:NO];
	}
	[docu release];
}


@end
