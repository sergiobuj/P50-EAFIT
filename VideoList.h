//
//  VideoList.h
//  P50
//
//  Created by Sergio Botero on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface VideoList : UITableViewController {
    NSMutableArray * videosAvailable;
}

@property (nonatomic, retain) NSMutableArray * videosAvailable;
@end
