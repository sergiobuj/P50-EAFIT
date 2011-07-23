//
//  FeedbackController.h
//  P50
//
//  Created by Sergio Botero on 7/10/11.
//  Copyright 2011 Sergiobuj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface FeedbackController : UIViewController <MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIButton * feedbackTypePickerButton;
	IBOutlet UIPickerView * feedbackCategoryPicker;
	IBOutlet UITextView * feedbackTextView;
	
	NSArray * feedbackCategories;
	NSString * selectedFeedbackCategory;
	UIBarButtonItem * sendButton;
	
	UIActivityIndicatorView * spinnerView;
	
	NSTimer * thankTimer;
}

@property (nonatomic, retain) NSTimer * thankTimer;

- (IBAction) showPicker;

@end
