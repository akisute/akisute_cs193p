//
//  TwitterHelperOperation.h
//  Presence
//
//  Created by 小野 将司 on 08/12/06.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPerson.h"

@interface THOFetchTimeLineForUserName : NSOperation {
	MPerson *person;
}

@property (nonatomic, retain) MPerson *person;

- (id)initWithPerson:(MPerson *)p;

@end
