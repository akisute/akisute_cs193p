//
//  PresenceAppDelegate.m
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "PresenceAppDelegate.h"
#import "PersonListViewController.h"
#import "MPerson.h"

@implementation PresenceAppDelegate

@synthesize window;
@synthesize personNavigation;


- (void)applicationDidFinishLaunching:(UIApplication *)application {  
	//Create an UINavigationController
	UINavigationController *navigationController = [[UINavigationController alloc] init];
	
	//Create a PersonListViewConteroller
	PersonListViewController *personListViewController = [[PersonListViewController alloc]
														  initWithNibName:@"PersonListViewController" 
														  bundle:nil];
	//Fetch from Twitter to create a person list
	NSArray *userNameList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
															pathForResource:@"TwitterUsers"
															ofType:@"plist"]];
	NSMutableArray *personList = [[NSMutableArray alloc] initWithCapacity:[userNameList count]];
	for (NSString *userName in userNameList) {
		MPerson *person = [[MPerson alloc] initWithTwitterUserName:userName];
		[personList addObject:person];
		[person release];
	}
	personListViewController.personList = personList;
	//And push it as the root view of navigationc controller
	[navigationController pushViewController:personListViewController animated:NO];
	self.personNavigation = navigationController;
	[navigationController release];
	
	[window addSubview:personNavigation.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[personNavigation release];
    [window release];
    [super dealloc];
}


@end
