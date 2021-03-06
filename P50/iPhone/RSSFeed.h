//
//  RSSFeed.h
//  iEAFIT
//
//  Created by Sergio Botero on 11/30/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//
#import "EGORefreshTableHeaderView.h"
#import <UIKit/UIKit.h>
#import "SBXMLParser.h"
#import "WebBrowserController.h"

@interface RSSFeed : UITableViewController <SBParserDelegate> {
	EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
	NSOperationQueue *xmlQueue;

	WebBrowserController * webBrowser;

	SBXMLParser * xmlParser;
	NSMutableArray *entries;
	NSString * _urlFeed;
}

@property (nonatomic, copy) NSString * urlFeed;
@property(assign,getter=isReloading) BOOL reloading;

- (void)reloadTableViewDataSource;

@end