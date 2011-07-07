//
//  VideoList.m
//  P50
//
//  Created by Sergio Botero on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoList.h"

@interface VideoList () 
- (void) fetchTableViewInfo;
- (void) finishFetchTableViewInfo;
@end

@implementation VideoList
@synthesize videosAvailable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) init {
	self = [super init];
	if (self) {
		videosAvailable = [[NSMutableArray alloc] init];
		[self fetchTableViewInfo];
	}
	
	return self;
}

- (void)dealloc
{
	[videosAvailable release];
	[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    static NSString *CellIdentifier = @"Cell";
    NSDictionary * video = [videosAvailable objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [video objectForKey:@"title"];

    return cell;
}


- (void) fetchTableViewInfo {

	NSDictionary * video = [[NSDictionary alloc] initWithObjectsAndKeys:@"Video 1",@"title",@"2001/10/10",@"date", @"http://trailers.apple.com/movies/independent/senna/senna-tlr1_480p.mov",@"videoURL", nil];
	
	[videosAvailable addObject:video];
	[video release];

	[self finishFetchTableViewInfo];
}

- (void) finishFetchTableViewInfo {
	[self.tableView reloadData];
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
