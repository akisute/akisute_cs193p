//
//  PersonListViewController.h
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPersonDataSource.h"
#import "ImageStore.h"

@interface PersonListViewController : UITableViewController {
	MPersonDataSource *personDataSource;
	ImageStore *imageStore;
}

@property (nonatomic, retain) MPersonDataSource *personDataSource;
@property (nonatomic, retain) ImageStore *imageStore;

//Refreshes fetched datas to redraw the view.
- (IBAction)refresh:(id)sender;

/*! Opens the modal view to input tweets. */
- (IBAction)openStatusComposeView:(id)sender;

/*! Opens the modal view to input twitter account info. */
- (IBAction)openInputAccountInfoView:(id)sender;

@end
