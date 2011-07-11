//
//  FeedbackController.m
//  P50
//
//  Created by Sergio Botero on 7/10/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "FeedbackController.h"


@implementation FeedbackController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = NSLocalizedString(@"send_feedback_title", @"feedback view title");
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) viewWillAppear:(BOOL)animated {
	MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc] init];
	mailComposer.mailComposeDelegate = self;
	[mailComposer setToRecipients: [NSArray arrayWithObject:NSLocalizedString(@"feedback_mail", @"")]];
	[mailComposer setSubject:NSLocalizedString(@"feedback_subject", @"")];
	[self presentModalViewController:mailComposer animated:YES];
	[mailComposer release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error {
	[self dismissModalViewControllerAnimated:NO];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
