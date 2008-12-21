//
//  MPersonDataSource.h
//  Presence
//
//  Created by 小野 将司 on 08/12/06.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MPersonDataSource : NSObject
{
	id delegate;
	NSMutableArray *personList;
	NSOperationQueue *operationQueue;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSMutableArray *personList;
@property (nonatomic, retain) NSOperationQueue *operationQueue;

/*! Initializes the datasource with the contents of specified plist. */
- (id)initWithContentsOfFile:(NSString *)aPath;
/*! Reloads all timelines. */
- (void)reload;
/*! Yes if all the person data has been already loaded: Otherwise NO. */
- (BOOL)isAllLoaded;

@end
