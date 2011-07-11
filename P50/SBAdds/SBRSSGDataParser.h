//
//  SBRSSGDataParser.h
//  P50
//
//  Created by Sergio Botero on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBRSSGDataParser : NSObject {
}

+ (void) parseRSS:(NSString *) rssurl withDelegate:(id) delegate;
@end
