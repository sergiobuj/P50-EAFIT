//
//  SBXMLParser.m
//  XMLParserSample
//
//  Created by Sergio Botero on 11/25/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "SBXMLParser.h"

static NSString * TITLE = @"title";
static NSString * DESCR = @"description";
static NSString * DATE = @"date";
static NSString * PUBDATE = @"pubDate";
static NSString * ITEM = @"item";
static NSString * LINK = @"link";

@implementation SBXMLParser
@synthesize delegate = _delegate;
@synthesize rssFeedURL = _rssFeedURL;

- (id) initWithUrl:(NSString *)url{
	self = [super init];
	if (self) {
		_rssFeedURL = [[NSString alloc] initWithString:url];
	}
	return self;
}


- (void) loadDocument {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSURL * url = [[NSURL alloc] initWithString:_rssFeedURL];
	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	NSXMLParser * rssParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	[rssParser setShouldProcessNamespaces:NO];
	
	[rssParser setShouldReportNamespacePrefixes:NO];
	[rssParser setShouldResolveExternalEntities:NO];
	[rssParser setDelegate:self];
	[rssParser parse];
	
	[rssParser release];
	[url release];
	
	[pool drain];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser {

	currElement = [[NSString alloc] init];
	resultEntries = [[NSMutableArray alloc] init];
}
	
- (void)parserDidEndDocument:(NSXMLParser *) parser {

	if ([self.delegate respondsToSelector:@selector(responseArray:)]) {
		[ (id)self.delegate performSelectorOnMainThread:@selector(responseArray:) withObject:resultEntries waitUntilDone:NO];
	}
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

	currElement = [elementName copy];

	if ([elementName isEqualToString:ITEM]) {
		
		currDate = [[NSMutableString alloc] init];
		currLink = [[NSMutableString alloc] init];
		currTitle = [[NSMutableString alloc] init];
		currDescription = [[NSMutableString alloc] init];
		
	}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	itemParsed = [[NSMutableDictionary alloc] init];
	
	if ([elementName isEqualToString:ITEM]) {
		[itemParsed setObject:currTitle forKey:TITLE];
		[itemParsed setObject:currDate forKey:DATE];
		[itemParsed setObject:currLink forKey:LINK];
		[itemParsed setObject:currDescription forKey:DESCR];
		[resultEntries addObject:itemParsed];
	}
	
	[itemParsed release];
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ([currElement isEqualToString:TITLE]) {
		[currTitle appendString:string];
		
	}else if ([currElement isEqualToString:LINK]) {
		string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
		string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		string = [string stringByReplacingOccurrencesOfString:@"	" withString:@""];
		[currLink appendString:string];
		
	}else if ([currElement isEqualToString:DESCR]) {
		[currDescription appendString:string];
		
	}else if ([currElement isEqualToString:PUBDATE]) {
		[currDate appendString:string];
		
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];

	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert autorelease];

}

- (void) dealloc{

	self.delegate = nil;
	[currDescription release];
	[currDate release];
	[currTitle release];
	[currLink release];
	[self.rssFeedURL release];
	[super dealloc];
}

@end
