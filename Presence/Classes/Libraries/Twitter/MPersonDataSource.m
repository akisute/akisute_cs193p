//
//  MPersonDataSource.m
//  Presence
//
//  Created by 小野 将司 on 08/12/06.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MPersonDataSource.h"
#import "MPerson.h"
#import "TwitterHelper.h"


@interface NSObject (MPersonDataSourceDelegate)
- (void)mPersonDataSourceDidFinishLoadOfPerson:(MPerson*)person;
- (void)mPersonDataSourceDidFailLoad;
@end


@implementation MPersonDataSource

@synthesize delegate;
@synthesize personList;
@synthesize operationQueue;

- (id)initWithContentsOfFile:(NSString *)aPath
{
	if (!aPath) return nil;
	
	if (self = [super init])
	{
		NSArray *userNameList = [NSArray arrayWithContentsOfFile:aPath];
		NSMutableArray *list = [[[NSMutableArray alloc] initWithCapacity:[userNameList count]] autorelease];
		for (NSString *userName in userNameList)
		{
			MPerson *person = [[MPerson alloc] initWithUserName:userName];
			[list addObject:person];
			[person release];
		}
		self.personList = list;
	}
	return self;
}

- (void)dealloc
{
	[self.operationQueue release];
	[self.personList release];
	[super dealloc];
}

- (void)reloadPerson:(MPerson *)person
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSArray *jsonList = [TwitterHelper fetchTimelineForUsername:person.screen_name];
	if (!jsonList)
	{
		person.isLoaded = NO;
		
		if ([delegate respondsToSelector:@selector(mPersonDataSourceDidFailLoad)])
		{
			[delegate performSelectorOnMainThread:@selector(mPersonDataSourceDidFailLoad) withObject:nil waitUntilDone:YES];
		}
	} else
	{
		for (int i = 0; i < [jsonList count]; i++)
		{
			id dict = [jsonList objectAtIndex:i];
			id userDict = [dict objectForKey:@"user"];
			
			if (person.name == nil)
			{
				person.name = [userDict objectForKey:@"name"];
			}
			
			if (person.profile_image_url == nil)
			{
				person.profile_image_url = [userDict objectForKey:@"profile_image_url"];
			}
			
			if (person.texts == nil)
			{
				person.texts = [NSMutableArray arrayWithCapacity:10];
			}
			NSString *text = [dict objectForKey:@"text"];
			[person.texts addObject:text];
		}
		
		person.isLoaded = YES;
		
		if ([delegate respondsToSelector:@selector(mPersonDataSourceDidFinishLoadOfPerson:)])
		{
			[delegate performSelectorOnMainThread:@selector(mPersonDataSourceDidFinishLoadOfPerson:) withObject:person waitUntilDone:YES];
		}
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)reload
{
	if (!self.operationQueue)
	{
		self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
		[self.operationQueue setMaxConcurrentOperationCount:1];
	}
	
	for (MPerson *person in self.personList)
	{
		person.isLoaded = NO;
		NSInvocationOperation *op = [[NSInvocationOperation alloc]
									 initWithTarget:self
									 selector:@selector(reloadPerson:)
									 object:person];
		[self.operationQueue addOperation:op];
		[op release];
	}
}

- (BOOL)isAllLoaded
{
	BOOL loaded = YES;
	for (MPerson *person in self.personList)
	{
		loaded &= person.isLoaded;
	}
	return loaded;
}

@end
