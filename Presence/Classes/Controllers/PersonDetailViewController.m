//
//  PersonDetailViewController.m
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PersonDetailViewController.h"


@implementation PersonDetailViewController

@synthesize person;

#pragma mark Memory deallocation and management

- (void)dealloc {
	[person release];
	[super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *str = nil;
	switch (section) {
		case 0:
			str = @"Statuses";
			break;
		default:
			break;
	}
	return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.person == nil) return 0;
    return self.person.texts.count;
}

// What's the difference between cellForRowAtIndexPath and willDisplayCell?
// I see, this method is called after cell is created and positioned. Hence we can use the cell frame property.
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	CGRect frame = cell.bounds;
	frame.origin.x += 10;
	frame.origin.y += 10;
	frame.size.width -= 40;
	frame.size.height -= 20;
	UILabel *myLabel = (UILabel *)[cell viewWithTag:100];
	myLabel.frame = frame;
	myLabel.text = [self.person.texts objectAtIndex:indexPath.row];
}

//Calculates the height of the cell. This method is called at the beginning of display of the table.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *str = [self.person.texts objectAtIndex:indexPath.row];
	UIFont *font = [UIFont systemFontOfSize:14];
	CGSize withinSize = CGSizeMake(tableView.frame.size.width-40.0, 10000);
	CGSize size = [str sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 20.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Statuses";
	static NSInteger LabelTag = 100;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		UILabel *myLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		myLabel.userInteractionEnabled = NO;
		myLabel.lineBreakMode = UILineBreakModeWordWrap;
		myLabel.numberOfLines = 0;
		myLabel.tag = LabelTag;
		myLabel.font = [UIFont systemFontOfSize:14];
		[cell.contentView addSubview:myLabel];
    }
	
    return cell;
}

// Prevent users from selecting a row
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end

