//
//  TwitterMessageSender.h
//  Presence
//
//  Created by 小野 将司 on 08/12/21.
//  Copyright 2008 Masashi Ono. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterMessageSender : NSObject
{
	NSOperationQueue *operationQueue;
}

@property (nonatomic, retain) NSOperationQueue *operationQueue;

/*! Sends a message. */
- (void)send:(NSString *)aMessage;

@end
