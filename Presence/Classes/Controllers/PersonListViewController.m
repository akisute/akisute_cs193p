//
//  PersonListViewController.m
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonDetailViewController.h"
#import "StatusComposeViewController.h"
#import "InputAccountInfoViewController.h"
#import "MPerson.h"
#import "TwitterAccountInfo.h"

@implementation PersonListViewController

@synthesize personDataSource;
@synthesize imageStore;

#pragma mark Initialize, deallocation, and memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	NSLog(@"%@", @"PersonListViewController dealloc");
	[personDataSource release];
    [super dealloc];
}

#pragma mark Action

- (IBAction)refresh:(id)sender
{
	if (!self.personDataSource)
	{
		NSString *aPath = [[NSBundle mainBundle] pathForResource:@"TwitterUsers" ofType:@"plist"];
		MPersonDataSource *ds = [[[MPersonDataSource alloc] initWithContentsOfFile:aPath] autorelease];
		ds.delegate = self;
		self.personDataSource = ds;
	}
	
	if (!self.imageStore)
	{
		self.imageStore = [[[ImageStore alloc] initWithDelegate:self] autorelease];
	}
	
	if ([TwitterAccountInfo isTwitterAccountReady])
	{
		[self.personDataSource reload];
	} else
	{
		[self openInputAccountInfoView:nil];
	}
}

- (IBAction)openStatusComposeView:(id)sender
{
	StatusComposeViewController *viewController = [[StatusComposeViewController alloc]
												   initWithNibName:@"StatusComposeViewController"
												   bundle:nil];
//	[[self navigationController] presentModalViewController:viewController animated:YES];
	[self presentModalViewController:viewController animated:YES];
	[viewController release];
}

- (IBAction)openInputAccountInfoView:(id)sender
{
	InputAccountInfoViewController *viewController = [[InputAccountInfoViewController alloc]
													  initWithNibName:@"InputAccountInfoViewController"
													  bundle:nil];
	[[self navigationController] presentModalViewController:viewController animated:YES];
	[viewController release];
}

#pragma mark UIViewController delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"People";
	UIBarButtonItem *composeButton = [[UIBarButtonItem alloc]
									  initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
									  target:self
									  action:@selector(openStatusComposeView:)];
	self.navigationItem.leftBarButtonItem = composeButton;
	[composeButton release];
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
									  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
									  target:self
									  action:@selector(refresh:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
}

#pragma mark UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.personDataSource.personList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
	MPerson *person = [self.personDataSource.personList objectAtIndex:indexPath.row];
	if (person.isLoaded)
	{
		cell.text = (person.name) ? person.name : person.screen_name;
		cell.image = [imageStore getImage:person.profile_image_url];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else
	{
		cell.text = @"Now loading...";
		cell.image = nil;
		cell.accessoryType = UITableViewCellAccessoryNone;
		// TODO Maybe UIActivityIndicatorView should be appeared
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MPerson *person = [self.personDataSource.personList objectAtIndex:indexPath.row];
	if (person.isLoaded)
	{
		PersonDetailViewController *personDetailViewController = [[PersonDetailViewController alloc]
																  initWithNibName:@"PersonDetailViewController"
																  bundle:nil];
		personDetailViewController.person = person;
//		personDetailViewController.tableView.tableHeaderView = nil;
		personDetailViewController.title = (person.name) ? person.name : person.screen_name;
		[self.navigationController pushViewController:personDetailViewController animated:YES];
		[personDetailViewController release];
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MPerson *person = [self.personDataSource.personList objectAtIndex:indexPath.row];
	if (!person.isLoaded)
	{
		return nil;
	}
	return indexPath;
}

#pragma mark MPersonDataSource delegate

- (void)mPersonDataSourceDidFinishLoadOfPerson:(MPerson *)person
{
	[self.tableView reloadData];
}

#pragma mark ImageStore delegate

- (void)imageStoreDidGetNewImage:(ImageStore*)sender url:(NSString*)url
{
	[self.tableView reloadData];
}

@end

