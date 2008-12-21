//
//  StatusComposeViewController.m
//  Presence
//
//  Created by 小野 将司 on 08/12/17.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import "StatusComposeViewController.h"


@implementation StatusComposeViewController

@synthesize messageText;
@synthesize submitButton;
@synthesize cancelButton;
@synthesize messageSender;

#pragma mark Initialize and dealloc

- (void)dealloc {
	[messageSender release];
	[messageText release];
	[submitButton release];
	[cancelButton release];
    [super dealloc];
}

#pragma mark Actions

- (IBAction)cancel:(id)sender
{
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendTweet:(id)sender
{
	//Send a message using PersonDataSource
	if (!messageSender)
	{
		self.messageSender = [[[TwitterMessageSender alloc] init] autorelease];
	}
	[self.messageSender send:self.messageText.text];
	
	//Return to the parent view
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark UIViewController delegate

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self sendTweet:textField];
	return NO;
}

@end
