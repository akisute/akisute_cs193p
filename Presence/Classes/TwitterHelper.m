//
//  TwitterHelper.m
//  Presence
//

#import "TwitterHelper.h"
#import "JSON.h"

@implementation TwitterHelper

+ (NSArray *)fetchTimelineForUsername:(NSString *)username
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/statuses/user_timeline/%@.json", username]];
	NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSArray *jsonValue = [string JSONValue];
    return jsonValue;
}

@end
