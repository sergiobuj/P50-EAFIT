//
//  WebBrowserController.m
//  P50
//
//  Created by Sergio Botero on 7/9/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "WebBrowserController.h"
#import "UIColor+SBColors.h"

@implementation WebBrowserController

@synthesize webView;
@synthesize buttonsToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		
		backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack:)];
		
		forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForward:)];
		
		spacerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		spinnerButton = [[UIBarButtonItem alloc] initWithCustomView:spinnerView];
		
		reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
	}
    return self;
}

- (void)dealloc
{
	[backButton release];
	[spacerButton release];
	[forwardButton release];
	[spinnerButton release];
	[reloadButton release];
	[spinnerView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.navigationItem setRightBarButtonItem:spinnerButton animated:YES];
	
	backButton.enabled = self.webView.canGoBack;
	forwardButton.enabled = self.webView.canGoForward;
	
	NSArray * toolbarButtons = [NSArray arrayWithObjects:backButton, forwardButton, spacerButton, reloadButton, nil];
	
	[self.buttonsToolbar setItems:toolbarButtons animated:YES];
}

//- (void) viewWillAppear:(BOOL)animated {
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction) goBack:(id)sender {
	backButton.enabled = self.webView.canGoBack;
	forwardButton.enabled = self.webView.canGoForward;
	[self.webView goBack];
}

- (IBAction) goForward:(id)sender {
	backButton.enabled = self.webView.canGoBack;
	forwardButton.enabled = self.webView.canGoForward;
	[self.webView goForward];
}

- (IBAction) reload:(id)sender {
	[self.webView reload];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[spinnerView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[spinnerView stopAnimating];
	backButton.enabled = self.webView.canGoBack;
	forwardButton.enabled = self.webView.canGoForward;
	self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
