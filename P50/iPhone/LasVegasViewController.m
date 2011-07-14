//
//  LasVegasViewController.m
//  P50
//
//  Created by Sergio Botero on 4/24/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import "LasVegasViewController.h"
#import "RSSFeed.h"
#import "UIColor+SBColors.h"


enum {
	ulises_tag,
	map_tag,
	news_tag
};

@implementation LasVegasViewController

- (id) init {
	self = [super init];
	if (self) {
		[super viewDidLoad];
		pagesDictionary = [[NSMutableDictionary alloc] init];
		modalViewPresentable = [[NSMutableSet alloc] init];
		
//		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logosimbolo_eafit copy"]];
//		[[self navigationItem] setTitleView:imageView];
//		[imageView release];
		
		
	}
	return self;
}


- (void)dealloc
{
	[pagesDictionary release];
	[modalViewPresentable release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	UIView * cookingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	

	
	CGFloat viewW = cookingView.frame.size.width;
	CGFloat viewH = cookingView.frame.size.height;
	CGFloat buttonYStart = 0.1;
	
	UIImageView * background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Internals2.png"]];
	[cookingView addSubview:background];
	[background release];
	
	NSArray *pages = [NSArray arrayWithArray:[SBPlistReader arrayForResource:@"pages" fromPlist:@"Customization"]];
	
	for ( NSArray * page in pages ) {
		for (NSDictionary * button in page) {
			UIButton * tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
			
			CGFloat posX = [[button objectForKey:@"posX"] floatValue];
			CGFloat posY = [[button objectForKey:@"posY"] floatValue];

			CGFloat sizeW = [[button objectForKey:@"sizeW"] floatValue];
			CGFloat sizeH = [[button objectForKey:@"sizeH"] floatValue];
			
			[tempButton setFrame:CGRectMake(viewW * posX, viewH * posY , viewW * sizeW , viewH * sizeH)];
			[tempButton setTitle:NSLocalizedString( [button objectForKey:@"title"] , @"") forState:UIControlStateNormal];
			
			NSString * classNameString = [NSString stringWithString:[button objectForKey:@"viewController"]];
			[tempButton setTitle:classNameString forState:UIControlStateApplication];
			[tempButton setTag:buttonYStart * 10];

			if ([[button objectForKey:@"presentMode"] isEqualToString:@"modal"]) {
				[modalViewPresentable addObject:[button objectForKey:@"viewController"]];
			}
			
			[tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[tempButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
			
			//[tempButton setBackgroundColor:[UIColor greenColor]];
			
			if( [classNameString isEqualToString:@""] || NSClassFromString(classNameString)== nil ){
				[tempButton setEnabled: NO];
				[tempButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
			} else {
				Class viewCClass = NSClassFromString(classNameString);
				if([pagesDictionary objectForKey:classNameString] == nil){
					id page = [[viewCClass alloc] init];
					[pagesDictionary setValue:page forKey:classNameString];
					
					[page release];

				}
				
			}
			
			[cookingView addSubview:tempButton];
			buttonYStart += 0.1;
		}
	}

	[self setView:cookingView];

	[cookingView release];
	
	[self showLoginModal:self];
	
}


- (void) showLoginModal:(id)sender{
	
	ModalViewLogin *stc  = [[ModalViewLogin alloc] init];
	stc.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:stc];
	[[navController navigationBar] setTintColor:[UIColor blueP50]];
	[self.navigationController presentModalViewController:navController animated:YES];
	self.navigationItem.prompt = nil;
	[navController release];
	[stc release];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) buttonPressed:(id)sender {
	
	NSString * viewCont = NSStringFromClass([[pagesDictionary objectForKey:[sender titleForState:UIControlStateApplication]] class]);
	if ([modalViewPresentable containsObject:viewCont]) {
		
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[pagesDictionary objectForKey:[sender titleForState:UIControlStateApplication]]];
		[[navController navigationBar] setTintColor:[UIColor blueP50]];
		[self.navigationController presentModalViewController:navController animated:YES];
		self.navigationItem.prompt = nil;
		[navController release];
		
	} else {
		[self.navigationController pushViewController:[pagesDictionary objectForKey: [sender titleForState:UIControlStateApplication]] animated:YES];
	}
	
	}


#pragma mark -
#pragma mark ModalViewDelegate Methods
- (void) loginWithUsername:(NSString *) username andPass:(NSString *)password {

	if ([username isEqualToString:@"user1"]) {
		[self dismissModalViewControllerAnimated:YES];		
	}else{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Login un/succesful" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (void) loginCancelled {
}

@end
