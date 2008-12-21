//
//  InputAccountInfoViewController.m
//  Presence
//
//  Created by 小野 将司 on 08/12/20.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import "InputAccountInfoViewController.h"
#import "TwitterAccountInfo.h"

@implementation InputAccountInfoViewController

@synthesize idTextField;
@synthesize passwordTextField;
@synthesize doneButton;

#pragma mark Initialization and dealloc

- (void)dealloc {
	[idTextField release];
	[passwordTextField release];
	[doneButton release];
    [super dealloc];
}

#pragma mark Actions

- (IBAction)inputDone:(id)sender
{
	[TwitterAccountInfo setTwitterId:idTextField.text];
	[TwitterAccountInfo setTwitterPassword:passwordTextField.text];
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == self.idTextField)
	{
		[self.passwordTextField becomeFirstResponder];
		return NO;
	} else if(textField == self.passwordTextField)
	{
		[self inputDone:textField];
		return NO;
	} else
	{
		//TODO this must be an unexpected error
		return NO;
	}
}

@end
