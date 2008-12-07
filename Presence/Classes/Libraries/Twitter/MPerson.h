//
//  MPerson.h
//  Presence
//
//  Created by 小野 将司 on 08/12/01.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MPerson : NSObject {
	NSString *profile_image_url;
	NSString *screen_name;
	NSString *name;
	NSMutableArray *texts;
	BOOL isLoaded;
}

@property (nonatomic, retain) NSString *profile_image_url;
@property (nonatomic, retain) NSString *screen_name;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *texts;
@property (nonatomic) BOOL isLoaded;

- (id)initWithUserName:(NSString *)userName;

@end
