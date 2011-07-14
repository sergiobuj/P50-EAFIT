//
//  LasVegasViewController.h
//  P50
//
//  Created by Sergio Botero on 4/24/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewLogin.h"
#import "SBPlistReader.h"

@class RSSFeed, CampusMap;

@interface LasVegasViewController : UIViewController <ModalViewLoginDelegate> {
    
	//	RSSFeed * newsFeed;
	//	CampusMap * campusMap;
	NSMutableSet * modalViewPresentable;
	NSMutableDictionary * pagesDictionary;

}

- (void) buttonPressed:(id) sender;
- (void) showLoginModal:(id)sender;
@end
