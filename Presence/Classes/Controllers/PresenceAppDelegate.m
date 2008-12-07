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
#import "MPersonDataSource.h"

@implementation PresenceAppDelegate

@synthesize window;
@synthesize personNavigation;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	UINavigationController *navigationController = [[UINavigationController alloc] init];
	self.personNavigation = navigationController;
	[navigationController release];
	navigationController = nil;
	
	PersonListViewController *personListViewController = [[PersonListViewController alloc]
														  initWithNibName:@"PersonListViewController"
														  bundle:nil];
	
	NSString *aPath = [[NSBundle mainBundle] pathForResource:@"TwitterUsers" ofType:@"plist"];
	MPersonDataSource *personDataSource = [[MPersonDataSource alloc] initWithContentsOfFile:aPath];
	personDataSource.delegate = personListViewController;
	personListViewController.personDataSource = personDataSource;
	[personDataSource release];
	personDataSource = nil;
	
	[personListViewController refresh:nil];
	[self.personNavigation pushViewController:personListViewController animated:NO];
	[window addSubview:personNavigation.view];
    [window makeKeyAndVisible];
}


- (void)dealloc
{
	[personNavigation release];
    [window release];
    [super dealloc];
}


@end
