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
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    id value = [string JSONValue];
	
	[string release];
	
    return ([value isKindOfClass:[NSArray class]] ? value : nil);
}

+ (NSArray *)fetchFriendsTimelineForUsername:(NSString *)username withPassword:(NSString *)password
{
    if (!username || !password) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/friends_timeline.json", username, password]];
	NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];	
    id value = [string JSONValue];
	
	[string release];
    
    return ([value isKindOfClass:[NSArray class]] ? value : nil);
}

+ (BOOL)updateStatus:(NSString *)status forUsername:(NSString *)username withPassword:(NSString *)password
{
    NSString *post = [NSString stringWithFormat:@"status=%@", [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@twitter.com/statuses/update.json", username, password]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
	// We should probably be parsing the data returned by this call, for now just check the error.
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return (error == nil);
}

@end
