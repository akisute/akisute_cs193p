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

#pragma mark Property

@synthesize profile_image_url;
@synthesize screen_name;
@synthesize name;
@synthesize texts;
@synthesize isLoaded;

- (NSString *)name {
	return (name) ? name : screen_name;
}

#pragma mark Initialize and deallocation

- (id)initWithUserName:(NSString *)userName {
	if (self = [super init]) {
		self.screen_name = userName;
	}
	return self;
}

- (void)dealloc {
	[profile_image_url release];
	[texts release];
	[name release];
	[screen_name release];
	[super dealloc];
}

#pragma mark NSObject

- (NSString *)description {
	return [NSString stringWithFormat:@"MPerson (%@ / %@)", self.screen_name, self.name];
}

@end
