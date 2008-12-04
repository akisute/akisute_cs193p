//
//  MPerson.h
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MPerson : NSObject {
	UIImage *image;
	NSString *userName;
	NSString *displayName;
	NSMutableArray *statuses;
}

@property (retain) UIImage *image;
@property (retain) NSString *userName;
@property (retain) NSString *displayName;
@property (retain) NSMutableArray *statuses;

- (id)initWithTwitterUserName:(NSString *)name;

@end
