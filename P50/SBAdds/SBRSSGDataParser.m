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
//static NSString * DATE = @"date";
static NSString * LINK = @"link";


@implementation SBRSSGDataParser

+ (void) parseRSS:(NSString *) rssurl withDelegate:(id) delegate{

	NSMutableArray * responseArray = [[[NSMutableArray alloc] init] autorelease];
	
	GDataXMLDocument * docu = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:rssurl]] options:0 error:nil];
	NSLog(@"gdataxmldocument -> %@", docu);
	
	NSArray *items = [docu nodesForXPath:@"//item" error:nil];
    for (GDataXMLElement *item in items) {
		NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//		NSLog(@"%@", [item elementsForName:TITLE]);
//		NSLog(@"%@", [item elementsForName:DESCR]);
//		NSLog(@"%@", [item elementsForName:DATE]);
//		NSLog(@"%@", [item elementsForName:PUBDATE]);
//		NSLog(@"%@", [item elementsForName:LINK]);
		
		
		NSLog(@" ---- ");
		
		for(GDataXMLElement *category in [item elementsForName:TITLE]) {
			NSLog(@"(title) %@", [category stringValue] );

        }

		
		for(GDataXMLElement *category in [item elementsForName:DESCR]) {
			NSLog(@"(descr) %@", [category stringValue] );
			
        }
		
		for(GDataXMLElement *category in [item elementsForName:LINK]) {
			NSLog(@"(link) %@", [category stringValue] );
			
        }
		
		
		
		[dict setObject:[[[item elementsForName:TITLE] objectAtIndex:0] stringValue] forKey:TITLE];
		[dict setObject:[[[item elementsForName:DESCR] objectAtIndex:0] stringValue] forKey:DESCR];
		[dict setObject:[[[item elementsForName:LINK] objectAtIndex:0] stringValue] forKey:LINK];
	
		[responseArray addObject:dict];
		
		[dict release];
	}
	
	if ([delegate respondsToSelector:@selector(responseArray:)]) {
		//[ (id)delegate performSelectorOnMainThread:@selector(responseArray:) withObject:responseArray waitUntilDone:NO];
	}
	
}


@end
