//
//  TwitterHelper.h
//  Presence
//

#import <UIKit/UIKit.h>

// For more on the Twitter API: http://apiwiki.twitter.com/REST+API+Documentation
// For more on the excellent json-framework: http://code.google.com/p/json-framework

@interface TwitterHelper : NSObject {

}

// This is a synchronous method- that is, it will block the calling thread.
// You will probably want to use the debugger to investigate the contents of the returned array.
+ (NSArray *)fetchTimelineForUsername:(NSString *)username;

@end
