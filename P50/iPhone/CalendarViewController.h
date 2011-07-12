//
//  CalendarViewController.h
//  P50
//
//  Created by Sergio Botero on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalendarViewController : UITableViewController {
    NSMutableArray * feedEntries;	
	UIActivityIndicatorView * spinnerView;
}

@end
