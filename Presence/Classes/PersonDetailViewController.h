//
//  PersonDetailViewController.h
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPerson.h"

@interface PersonDetailViewController : UITableViewController {
	MPerson *person;
}

@property (nonatomic, retain) MPerson *person;

@end
