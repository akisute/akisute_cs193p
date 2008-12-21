//
//  TwitterAccountInfo.h
//  Presence
//
//  Created by 小野 将司 on 08/12/21.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterAccountInfo : NSObject
{
}

+ (NSString *)twitterId;
+ (void)setTwitterId:(NSString *)anId;

+ (NSString *)twitterPassword;
+ (void)setTwitterPassword:(NSString *)aPassword;

/*! Yes if ID/Password is ready to use: Otherwise NO. */
+ (BOOL)isTwitterAccountReady;

@end
