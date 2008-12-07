//
//  TwitterHelper.h
//  Presence
//

#import <UIKit/UIKit.h>

// For more on the Twitter API: http://apiwiki.twitter.com/REST+API+Documentation
// For more on json-framework: http://code.google.com/p/json-framework

@interface TwitterHelper : NSObject {
	
}

// Synchronous method returns an array of status updates for the given username.
// To figure out how to use it, inspect the contents of the array using NSLog or the debugger.
+ (NSArray *)fetchTimelineForUsername:(NSString *)username;

// Synchronous method posts a status update for the given username and password.
// Returns YES if the status update succeeded, NO if it failed.
+ (BOOL)updateStatus:(NSString *)status forUsername:(NSString *)username withPassword:(NSString *)password;

@end

@interface TwitterHelper (ExtraCredit)
// Synchronous method returns an array of the latest status updates for the specified username's friends.
// This is only needed if you're pursuing one of the extra credit options.
+ (NSArray *)fetchFriendsTimelineForUsername:(NSString *)username withPassword:(NSString *)password;
@end