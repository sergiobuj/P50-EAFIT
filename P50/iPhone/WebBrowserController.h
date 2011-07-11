//
//  WebBrowserController.h
//  P50
//
//  Created by Sergio Botero on 7/9/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebBrowserController : UIViewController <UIWebViewDelegate>{
	UIActivityIndicatorView * spinnerView;
	IBOutlet UIWebView * webView;
	IBOutlet UIToolbar * buttonsToolbar;
	
	UIBarButtonItem * backButton;
	UIBarButtonItem * forwardButton;
	UIBarButtonItem * spacerButton;
	UIBarButtonItem * spinnerButton;
	UIBarButtonItem * reloadButton;
	
}
@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIToolbar * buttonsToolbar;

- (IBAction) goBack:(id)sender;
- (IBAction) goForward:(id)sender;
- (IBAction) reload:(id)sender;


@end
