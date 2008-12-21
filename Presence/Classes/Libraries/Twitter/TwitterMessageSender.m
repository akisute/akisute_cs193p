//
//  TwitterMessageSender.m
//  Presence
//
//  Created by 小野 将司 on 08/12/21.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import "TwitterMessageSender.h"
#import "TwitterAccountInfo.h"
#import "TwitterHelper.h"


/*! Private methods declaration */
@interface TwitterMessageSender(Private)
- (void)_send:(NSString *)aMessage;
@end


@implementation TwitterMessageSender

@synthesize operationQueue;

#pragma mark Initialize and dealloc;

- (id)init
{
	if (self = [super init])
	{
		self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
		[self.operationQueue setMaxConcurrentOperationCount:2];
	}
	return self;
}

- (void)dealloc
{
	[self.operationQueue release];
	[super dealloc];
}

#pragma mark Methods

- (void)send:(NSString *)aMessage
{
	NSInvocationOperation *op = [[NSInvocationOperation alloc]
								 initWithTarget:self
								 selector:@selector(_send:)
								 object:aMessage];
	[self.operationQueue addOperation:op];
	[op release];
}

#pragma mark Private methods implementation

- (void)_send:(NSString *)aMessage
{
	NSString *username = [TwitterAccountInfo twitterId];
	NSString *password = [TwitterAccountInfo twitterPassword];
	BOOL result = [TwitterHelper updateStatus:(NSString *)aMessage
								  forUsername:(NSString *)username
								 withPassword:(NSString *)password];
	//TODO do something with result, maybe use delegate?
	if (result)
	{
	} else
	{
	}
}

@end
