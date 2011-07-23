//
//  ModalViewLogin.m
//  AuthenticationModal
//
//  Created by Sergio Botero on 11/15/10.
//  Copyright 2010 Sergiobuj. All rights reserved.
//

#import "ModalViewLogin.h"
#import "UIColor+SBColors.h"

#define yFieldPos 90

@implementation ModalViewLogin
@synthesize delegate;
@synthesize userField;
@synthesize passField;

- (void)loadView {
    [super viewDidLoad];

	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
	
	UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login.png"]];
	[contentView addSubview:background];
	[background release];
	
	userField = [[UITextField alloc] initWithFrame:CGRectMake(10, yFieldPos, contentView.frame.size.width-20, 45)];
	passField = [[UITextField alloc] initWithFrame:CGRectMake(10, yFieldPos + 60, contentView.frame.size.width-20, 45)];
	
	[userField setPlaceholder:NSLocalizedString(@"user_id_placeholder", @"")];
	[passField setPlaceholder:NSLocalizedString(@"user_pass_placeholder", @"")];
	
	//text field setup
	userField.borderStyle = UITextBorderStyleRoundedRect;
	passField.borderStyle = UITextBorderStyleRoundedRect;

	passField.secureTextEntry = YES;

	userField.returnKeyType = UIReturnKeyNext;
	passField.returnKeyType = UIReturnKeyDone;
	
	[userField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	
	
	[userField setFont:[UIFont systemFontOfSize:30.0]];
	[passField setFont:[UIFont systemFontOfSize:30.0]];
	
	//content view setup
	contentView.backgroundColor = [UIColor blueP50];
	[contentView addSubview:userField];
	[contentView addSubview:passField];

	userField.delegate = self;
	userField.tag = 1;
	passField.delegate = self;
	passField.tag = 2;
	
	//view setup
	self.view = contentView;
	self.title = NSLocalizedString(@"login_mod_title",@"");	

	//release
	[contentView release];
}


#warning Should remove cancel login button
- (void)viewDidLoad {
    [super viewDidLoad];

	UIBarButtonItem *cancelB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButton)];
	UIBarButtonItem * loginB = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"login_title", @"login button title") style:UIBarButtonItemStyleDone target:self action:@selector(login)];

	self.navigationItem.rightBarButtonItem = loginB;
	self.navigationItem.leftBarButtonItem = cancelB;
		
	[loginB release];
	[cancelB release];
}

- (void) cancelButton{

	if ([self.delegate respondsToSelector:@selector(loginCancelled)]) {
		[self dismissModalViewControllerAnimated:YES];
		[self.delegate loginCancelled];
	}

}

-(void) login{
	if ([self.delegate respondsToSelector:@selector(loginWithUsername:andPass:)]) {
		[self.delegate loginWithUsername:[userField text] andPass:[passField text]];
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if( textField.tag == 1){
		[passField becomeFirstResponder];
	}else{
		[self login];
	}
	
	return YES;
}


- (void)dealloc {
	[userField release];
	[passField release];
	[super dealloc];
}

@end
