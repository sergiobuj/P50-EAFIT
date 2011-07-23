//
//  AboutP50Controller.m
//  P50
//
//  Created by Sergio Botero on 7/14/11.
//  Copyright 2011 EAFIT I+D. All rights reserved.
//

#import "AboutP50Controller.h"


@implementation AboutP50Controller

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *cancelB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModalViewControllerAnimated:)];
	
	self.navigationItem.leftBarButtonItem = cancelB;
	
	[cancelB release];
}

@end
