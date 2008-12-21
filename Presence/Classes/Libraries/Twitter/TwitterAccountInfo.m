//
//  TwitterAccountInfo.m
//  Presence
//
//  Created by 小野 将司 on 08/12/21.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import "TwitterAccountInfo.h"


@implementation TwitterAccountInfo

+ (NSString *)twitterId
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults stringForKey:@"twitterId"];
}

+ (void)setTwitterId:(NSString *)anId
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:anId forKey:@"twitterId"];
}

+ (NSString *)twitterPassword
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults stringForKey:@"twitterPassword"];
}

+ (void)setTwitterPassword:(NSString *)aPassword
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:aPassword forKey:@"twitterPassword"];	
}

#pragma mark Methods

+ (BOOL)isTwitterAccountReady
{
	return ([TwitterAccountInfo twitterId] && [TwitterAccountInfo twitterPassword]);
}
@end
