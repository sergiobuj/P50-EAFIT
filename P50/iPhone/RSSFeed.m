//
//  RSSFeed.m
//  iEAFIT
//
//  Created by Sergio Botero on 11/30/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "SBPlistReader.h"
#import "SBXMLParser.h"
#import "RSSFeed.h"

@interface RSSFeed (Private)

- (void)dataSourceDidFinishLoadingNewData;

@end

@implementation RSSFeed

@synthesize reloading = _reloading;
@synthesize urlFeed = _urlFeed;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	
    [super viewDidLoad];
	[self setTitle:NSLocalizedString(@"news_title", @"")];
	
	if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320.0f, self.tableView.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[self.tableView addSubview:refreshHeaderView];
		self.tableView.showsVerticalScrollIndicator = YES;
		[refreshHeaderView release];
	}
	
	webBrowser = [[WebBrowserController alloc] init];
	
	entries = [[NSMutableArray alloc] init];
	xmlQueue = [[NSOperationQueue alloc] init];

	if (_urlFeed == nil) {
		NSString *plistUrl =  [[SBPlistReader dictionaryForResource:@"rss_feeds" fromPlist:@"Customization"] objectForKey:@"RSSFeed"];
		_urlFeed = [[NSString alloc] initWithString:plistUrl];
	}

	xmlParser = [[SBXMLParser alloc] initWithUrl:_urlFeed];
	
	[xmlParser setDelegate:self];

	[refreshHeaderView setState:EGOOPullRefreshLoading];
	self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
	[self reloadTableViewDataSource];
}

- (void) LoadXML{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[xmlQueue addOperationWithBlock:^{
		[xmlParser loadDocument];
	}];
	
	
	[pool drain];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
	//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [entries count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.imageView.image = [UIImage imageNamed:@"icon.png"];
	//	cell.detailTextLabel.text = @"";
    cell.textLabel.text = [[entries objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString * link = [[entries objectAtIndex: indexPath.row] objectForKey: @"link"];
	NSURLRequest * siteRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];


	
	[self.navigationController pushViewController:webBrowser animated:YES];
	[webBrowser.webView loadRequest:siteRequest];
	[self.tableView deselectRowAtIndexPath: indexPath animated: YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	refreshHeaderView = nil;

}


- (void)dealloc {
	[webBrowser release];
	[_urlFeed release];
	[xmlQueue release];
	[xmlParser release];
	refreshHeaderView = nil;
    [super dealloc];
}




#pragma mark -
#pragma mark SBParserDelegate
- (void) responseArray:(NSMutableArray *)array
{
	
	[entries removeAllObjects];
	[entries setArray:array];
	[self.tableView reloadData];
	[self dataSourceDidFinishLoadingNewData];

}

#pragma mark -
#pragma mark EGOOPullRefresh Methods

- (void)reloadTableViewDataSource{
	[self LoadXML];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		_reloading = YES;
		[self reloadTableViewDataSource];
		[refreshHeaderView setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}

- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];
}

@end

