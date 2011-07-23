//
//  SBXMLParser.h
//  XMLParserSample
//
//  Created by Sergio Botero on 11/25/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBParserDelegate;

@interface SBXMLParser : NSObject <NSXMLParserDelegate>{
	NSMutableDictionary * itemParsed;
	NSMutableArray * resultEntries;

	NSString *_rssFeedURL;
	NSString * currElement;
	NSMutableString * currLink;
	NSMutableString * currDate;
	NSMutableString * currTitle;
	NSMutableString * currDescription;
	id <SBParserDelegate> _delegate ;

}

@property (nonatomic, retain) id <SBParserDelegate> delegate;
@property (nonatomic, copy) NSString * rssFeedURL;

- (id) initWithUrl:(NSString *)url;
- (void) loadDocument;

@end

@protocol SBParserDelegate <NSObject>
- (void) responseArray:(NSMutableArray *) array;
@end