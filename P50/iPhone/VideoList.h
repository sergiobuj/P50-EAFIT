//
//  VideoList.h
//  P50
//
//  Created by Sergio Botero on 7/7/11.
//  Copyright 2011 EAFIT I+D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>


@interface VideoList : UITableViewController {
    NSMutableArray * videosAvailable;
	UIActivityIndicatorView *spinnerView;
}

@property (nonatomic, retain) NSMutableArray * videosAvailable;
@end
