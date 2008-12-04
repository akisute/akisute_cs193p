//
//  MPerson.m
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MPerson.h"
#import "TwitterHelper.h";

@implementation MPerson

@synthesize image;
@synthesize userName;
@synthesize displayName;
@synthesize statuses;

- (NSString *)description {
	return [NSString stringWithFormat:@"MPerson (%@ / %@)", userName, displayName];
}

- (id)initWithTwitterUserName:(NSString *)name {
	if ((self = [super init]) != nil) {
		NSArray *jsonList = [TwitterHelper fetchTimelineForUsername:name];
		if (jsonList == nil) return nil;
		
		for (int i = 0; i < [jsonList count]; i++) {
			id dict = [jsonList objectAtIndex:i];
			id userDict = [dict objectForKey:@"user"];
			if (self.userName == nil) self.userName = [userDict objectForKey:@"screen_name"];
			if (self.displayName == nil) self.displayName = [userDict objectForKey:@"name"];
			if (self.image == nil) {
				NSString *imageURLString = [userDict objectForKey:@"profile_image_url"];
//				imageURLString = [imageURLString stringByReplacingOccurrencesOfString:@"¥" withString:@""];
				NSURL *imageURL = [NSURL URLWithString:imageURLString];
				if (imageURL != nil) {
					NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
					if (imageData != nil) {
						self.image = [UIImage imageWithData:imageData];
					}
				}
			}
			if (self.statuses == nil) {
				self.statuses = [NSMutableArray arrayWithCapacity:6];
			}
			NSString *text = [dict objectForKey:@"text"];
			[self.statuses addObject:text];
		}
	}
	return self;
}

@end
