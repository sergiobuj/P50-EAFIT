//
//  CalendarViewController.m
//  P50
//
//  Created by Sergio Botero on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarViewController.h"
#import "GDataCalendar.h"
#import "SBPlistReader.h"
#import "UIColor+SBColors.h"

@implementation CalendarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.tableView.rowHeight = 70;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation { return YES; }

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	if(spinnerView == nil)
		spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:spinnerView] autorelease]; 
	NSString * plisturl = [[SBPlistReader dictionaryForResource:@"rss_feeds" fromPlist:@"Customization"] objectForKey:NSStringFromClass([self class])];
	NSURL * feedurl = [NSURL URLWithString:plisturl];

	if (feedEntries == nil) {
		feedEntries = [[NSMutableArray alloc] init];
	}
	
	static GDataServiceGoogleCalendar* service = nil;
	
	if (!service) {
		service = [[GDataServiceGoogleCalendar alloc] init];

		[service setShouldCacheResponseData:YES];
		[service setServiceShouldFollowNextLinks:YES];
		[service setIsServiceRetryEnabled:YES];
		
	}
	
	[self.tableView setSeparatorColor:[UIColor yellowP50]];
	
	
	[spinnerView startAnimating];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//	[service fetchFeedWithURL:feedurl
//					 delegate:self
//			didFinishSelector:@selector(calendarListTicket:finishedWithFeed:error:)];
	//	NSLog(@"------- %@", feedurl );
	
	GDataQueryCalendar *query = [GDataQueryCalendar calendarQueryWithFeedURL:feedurl];
	[query setMaxResults:100];
	[query setOrderBy:@"starttime"];
	[query setIsAscendingOrder:YES];
	[service fetchFeedWithQuery:query
					   delegate:self
			  didFinishSelector:@selector(calendarEventsTicket:finishedWithFeed:error:)];
	
}

#warning SB 3logs
- (void)calendarEventsTicket:(GDataServiceTicket *)ticket
			finishedWithFeed:(GDataFeedCalendarEvent *)feed
					   error:(NSError *)error {
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	

	for (GDataEntryCalendar *obj in [feed entries]) {
		//		NSLog(@"%@",[obj valueForKeyPath:@"title.stringValue"]);
		
		//GDataXMLElement * summ = [obj valueForKeyPath:@"summary"];
		//		NSLog(@"%@",[obj valueForKeyPath:@"authors"]);
		//		GDataAtomAuthor
		//		for (NSString * str in [[obj properties]allValues]) {
		//			NSLog(@"->%@<-", str);
		//		}
		//		NSLog(@"%@", [summ stringValue]);

		//		NSLog(@" ");
	}
	
	
	[feedEntries setArray:[feed entries]];
	[self.tableView reloadData];
	
	[spinnerView stopAnimating];
}

- (void)calendarListTicket:(GDataServiceTicket *)ticket
          finishedWithFeed:(GDataFeedCalendar *)feed
                     error:(NSError *)error {

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	if (error == nil) { 
		[feedEntries setArray:[feed entries]];

		[self.tableView reloadData];
	} else {
		NSLog(@"fetch error: %@", error);
	}

	[spinnerView stopAnimating];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [feedEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	GDataEntryCalendar *thisCalendar = [feedEntries objectAtIndex:indexPath.row];
	
	cell.imageView.image = [UIImage imageNamed:@"Icon.png"];
	cell.textLabel.text = [[thisCalendar title] stringValue];
	cell.detailTextLabel.text = [[thisCalendar content] contentStringValue];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
