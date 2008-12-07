//
//  MPersonDataSource.h
//  Presence
//
//  Created by 小野 将司 on 08/12/06.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MPersonDataSource : NSObject {
	id delegate;
	NSMutableArray *personList;
	NSOperationQueue *operationQueue;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSMutableArray *personList;
@property (nonatomic, retain) NSOperationQueue *operationQueue;

- (id)initWithContentsOfFile:(NSString *)aPath;
- (void)reload;
- (BOOL)isAllLoaded;

@end
