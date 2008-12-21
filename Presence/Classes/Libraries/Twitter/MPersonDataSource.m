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


/*! Delegate declaration */
@interface NSObject(MPersonDataSourceDelegate)
- (void)mPersonDataSourceDidFinishLoadOfPerson:(MPerson*)person;
- (void)mPersonDataSourceDidFailLoad;
@end

/*! Private methods declaration */
@interface MPersonDataSource(Private)
- (void)reloadPerson:(MPerson *)person;
@end

#pragma mark -

@implementation MPersonDataSource

@synthesize delegate;
@synthesize personList;
@synthesize operationQueue;

#pragma mark Initialize and dealloc

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
		
		self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
		[self.operationQueue setMaxConcurrentOperationCount:2];
	}
	return self;
}

- (void)dealloc
{
	[self.operationQueue release];
	[self.personList release];
	[super dealloc];
}

#pragma mark Methods

- (void)reload
{	
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

#pragma mark Private methods implementation

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
				NSString *originalUrl = [userDict objectForKey:@"profile_image_url"];
				NSString *encodedUrl = (NSString *) CFURLCreateStringByAddingPercentEscapes
				(NULL, (CFStringRef) originalUrl, NULL, NULL, kCFStringEncodingUTF8);
				person.profile_image_url = encodedUrl;
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

@end
