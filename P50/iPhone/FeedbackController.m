//
//  FeedbackController.m
//  P50
//
//  Created by Sergio Botero on 7/10/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "FeedbackController.h"
#import "UIColor+SBColors.h"

#define kSecondsToDisplayThankNote 5.0

@interface FeedbackController ()

- (void) restoreFeedbackFields; 
- (void) sendFeedback;
- (void) removeThankNote;

@end


@implementation FeedbackController
@synthesize thankTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"send_feedback_title", @"feedback view title");
		sendButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"send_feedback", @"") style:UIBarButtonItemStyleDone target:self action:@selector(sendFeedback)];
		selectedFeedbackCategory = [[NSString alloc] init];
		spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		
		
		
	}
    return self;
}

- (void)dealloc
{
	[spinnerView release];
	[sendButton release];
	[feedbackCategories release];
    [super dealloc];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *cancelB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModalViewControllerAnimated:)];
	
	self.navigationItem.leftBarButtonItem = cancelB;
	
	[cancelB release];

	self.navigationItem.rightBarButtonItem = sendButton;
	
	[feedbackTypePickerButton setTitle:NSLocalizedString(@"enter_feedback_category", @"feedback category")forState:UIControlStateNormal];
	
	feedbackCategories = [[NSArray alloc] initWithObjects:NSLocalizedString(@"feedback_suggestion", @""),
						  NSLocalizedString(@"feedback_question", @""),
						  NSLocalizedString(@"feedback_general", @""),
						  NSLocalizedString(@"feedback_other", @""), 
						  nil];
	
	[feedbackTextView becomeFirstResponder];
}

#pragma mark - View lifecycle
- (void) viewWillAppear:(BOOL)animated {
	
	// Using mail	
	//	MFMailComposeViewController * mailComposer = [[MFMailComposeViewController alloc] init];
	//	mailComposer.mailComposeDelegate = self;
	//	[mailComposer setToRecipients: [NSArray arrayWithObject:NSLocalizedString(@"feedback_mail", @"")]];
	//	[mailComposer setSubject:NSLocalizedString(@"feedback_subject", @"")];
	//	[[mailComposer navigationBar] setTintColor:[UIColor blueP50]];
	//	[self presentModalViewController:mailComposer animated:YES];
	//	[mailComposer release];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *) error {
	[self dismissModalViewControllerAnimated:NO];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) showPicker {
	[feedbackTextView resignFirstResponder];
	feedbackCategoryPicker.hidden = NO;
}

- (void) removeThankNote {
	self.navigationItem.prompt = nil;
	[thankTimer invalidate];
}

#warning SB Send Feedback service
- (void) sendFeedback {
	[spinnerView startAnimating];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:spinnerView] autorelease];	
	
	NSLog(@"%@ %@", [feedbackCategories objectAtIndex:[feedbackCategoryPicker selectedRowInComponent:0] ], [feedbackTextView text] );
	
	self.navigationItem.prompt = NSLocalizedString(@"thank_you_feedback", @"");

	[self setThankTimer:[NSTimer scheduledTimerWithTimeInterval:kSecondsToDisplayThankNote target:self selector:@selector(removeThankNote) userInfo:nil repeats:NO]];
	
	[spinnerView stopAnimating];
	[self.navigationController popToRootViewControllerAnimated:YES];
	
	[self restoreFeedbackFields];
}

- (void) restoreFeedbackFields {
	[feedbackTypePickerButton setTitle:NSLocalizedString(@"enter_feedback_category", @"feedback category")forState:UIControlStateNormal];
	
	self.navigationItem.rightBarButtonItem = sendButton;
	
	[feedbackTextView setText:@""];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[feedbackTypePickerButton setTitle:NSLocalizedString([feedbackCategories objectAtIndex:row], @"feedback category")forState:UIControlStateNormal];
	
	selectedFeedbackCategory = NSLocalizedString([feedbackCategories objectAtIndex:row], @"feedback category");
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [feedbackCategories objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [feedbackCategories count];
}

@end
