//
//  StatusComposeViewController.h
//  Presence
//
//  Created by 小野 将司 on 08/12/17.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterMessageSender.h"


@interface StatusComposeViewController : UIViewController
{
	UITextField *messageText;
	UIButton *submitButton;
	UIButton *cancelButton;
	TwitterMessageSender *messageSender;
}

@property (nonatomic, retain) IBOutlet UITextField *messageText;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) TwitterMessageSender *messageSender;

// Cancel this dialog and returns to the parent view.
- (IBAction)cancel:(id)sender;
// Sends a tweet.
- (IBAction)sendTweet:(id)sender;

@end
