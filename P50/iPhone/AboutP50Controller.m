//
//  AboutP50Controller.m
//  P50
//
//  Created by Sergio Botero on 7/14/11.
//  Copyright 2011 EAFIT I+D. All rights reserved.
//

#import "AboutP50Controller.h"
#import "UIColor+SBColors.h"

@implementation AboutP50Controller

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *cancelB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModalViewControllerAnimated:)];
	
	self.navigationItem.leftBarButtonItem = cancelB;
	
	p50AboutLabel.text = NSLocalizedString(@"p50_what_is", @"What p50");
	p50AboutLabel.textColor = [UIColor lightBlueP50];
	
	backgroundView.image = [UIImage imageNamed:@"AboutBackground.png"];

	aboutText.text = NSLocalizedString(@"about_p50_text", @"complete text with p50 about");
	aboutText.textColor = [UIColor lightGrayColor];
	
	bannerView.image = [UIImage imageNamed:@"p50_about_people.jpg"];
	
	
	[cancelB release];
}

@end
