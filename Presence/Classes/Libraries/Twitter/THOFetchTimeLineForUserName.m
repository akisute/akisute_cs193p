//
//  TwitterHelperOperation.m
//  Presence
//
//  Created by 小野 将司 on 08/12/06.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "THOFetchTimeLineForUserName.h"

@implementation THOFetchTimeLineForUserName

@synthesize person;

- (id)initWithPerson:(MPerson *)p {
	if (self = [super init]) {
		self.person = p;
	}
	
	return self;
}



@end
