//
//  VideoList.m
//  P50
//
//  Created by Sergio Botero on 7/7/11.
//  Copyright 2011 EAFIT I+D. All rights reserved.
//

#import "VideoList.h"
#import "SBPlistReader.h"
#import "UIColor+SBColors.h"
#import "VideoCell.h"

@interface VideoList () 
- (void) fetchTableViewInfo;
- (void) finishFetchTableViewInfo;
@end

@implementation VideoList
@synthesize videosAvailable;

- (id) init {
	self = [super init];
	if (self) {
		videosAvailable = [[NSMutableArray alloc] init];
		[self fetchTableViewInfo];
		spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:spinnerView] autorelease];
	}
	
	return self;
}

- (void)dealloc
{
	[videosAvailable release];
	[super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.separatorColor = [UIColor yellowP50];
	self.tableView.rowHeight = 70.0;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [videosAvailable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    NSDictionary * video = [videosAvailable objectAtIndex:indexPath.row];

    VideoCell *cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [video objectForKey:@"title"];

    return cell;
}

// TODO: Fetch video list from WebService
#warning SB This Implementations is missing the real web service call
- (void) fetchTableViewInfo {
	[spinnerView startAnimating];

	// Loading videos from 
	[videosAvailable setArray: [SBPlistReader arrayForResource:@"videos" fromPlist:@"Customization"]];
	
	[self finishFetchTableViewInfo];
}

- (void) finishFetchTableViewInfo {
	[self.tableView reloadData];
	[spinnerView stopAnimating];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary * video = [videosAvailable objectAtIndex:indexPath.row];
	
	NSURL * videoURL = [NSURL URLWithString:[video objectForKey:@"videoURL"]];
	
	MPMoviePlayerViewController * moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
	
	[self presentMoviePlayerViewControllerAnimated:moviePlayer];

}

@end
