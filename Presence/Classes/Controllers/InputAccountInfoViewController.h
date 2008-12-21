//
//  InputAccountInfoViewController.h
//  Presence
//
//  Created by 小野 将司 on 08/12/20.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPersonDataSource.h"


//Probably <UITextFieldDelegate> protocol implementation is not required
@interface InputAccountInfoViewController : UIViewController <UITextFieldDelegate>
{
	UITextField *idTextField;
	UITextField *passwordTextField;
	UIButton *doneButton;
}

@property (nonatomic, retain) IBOutlet UITextField *idTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;

/*! Called when input is completed */
- (IBAction)inputDone:(id)sender;

@end
