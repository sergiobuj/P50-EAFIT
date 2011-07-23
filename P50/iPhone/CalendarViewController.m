//
//  CalendarViewController.m
//  P50
//
//  Created by Sergio Botero on 7/11/11.
//  Copyright 2011 EAFIT I+D. All rights reserved.
//

#import "CalendarViewController.h"
#import "GDataCalendar.h"
#import "SBPlistReader.h"
#import "UIColor+SBColors.h"

@implementation CalendarViewController

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
	
	self.tableView.separatorColor = [UIColor yellowP50];
	self.tableView.rowHeight = 70.0;
	
	[spinnerView startAnimating];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
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
	
	/*
	for (GDataEntryCalendar *obj in [feed entries]) {
		GDataXMLElement * summ = [obj valueForKeyPath:@"summary"];
		NSLog(@"%@", [summ stringValue]);
	}
	*/
	
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
