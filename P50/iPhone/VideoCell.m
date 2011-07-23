//
//  VideoCell.m
//  P50
//
//  Created by Sergio Botero on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoCell.h"


@implementation VideoCell

@synthesize detailTextLabel, videoImageView, textLabel, ownerLabel, dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 107, 64 )];
//		textLabel = [[UILabel alloc] initWithFrame:(CGRect)];
//		detailTextLabel = [[UILabel alloc] initWithFrame:(CGRect)];
//		ownerLabel = [[UILabel alloc] initWithFrame:(CGRect)];
//		dateLabel = [[UILabel alloc] initWithFrame:(CGRect)];
		
		
		
		[videoImageView setBackgroundColor:[UIColor redColor]];
		[self addSubview:videoImageView];
		NSLog(@"w:%f h:%f x:%f y:%f",self.frame.size.width,self.frame.size.height,self.frame.origin.x,self.frame.origin.y);
	}
    return self;
}

- (void) drawRect:(CGRect)rect {

}

- (void)dealloc
{
	[videoImageView release];
	//	[textLabel release];
	//	[detailTextLabel release];
	//	[ownerLabel release];
	//	[dateLabel release];
    [super dealloc];
}

@end
