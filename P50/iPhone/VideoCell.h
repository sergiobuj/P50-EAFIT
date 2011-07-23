//
//  VideoCell.h
//  P50
//
//  Created by Sergio Botero on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoCell : UITableViewCell {
    UIImageView * videoImageView;
	UILabel * textLabel;
	UILabel * detailTextLabel;
	UILabel * ownerLabel;
	UILabel * dateLabel;
}

@property (nonatomic, retain) UIImageView * videoImageView;
@property (nonatomic, retain) UILabel * textLabel;
@property (nonatomic, retain) UILabel * detailTextLabel;
@property (nonatomic, retain) UILabel * ownerLabel;
@property (nonatomic, retain) UILabel * dateLabel;

@end