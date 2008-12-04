//
//  PersonListViewController.h
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonListViewController : UITableViewController {
	NSArray *personList;
}

/** List of MPerson. */
@property (nonatomic, retain) NSArray *personList;

@end
