//
//  FBRequestWrapper.m
//  Cactus
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import "FBRequestWrapper.h"

@implementation FBRequestWrapper
@synthesize facebook, graphUrl, parsedResult;
@synthesize delegate;

-(id) initWithGraphPath:(NSString *)path
{
    self=[super init];
    if(self){
        graphUrl=path;
        facebook = [[Facebook alloc] initWithAppId:@"209544885800817" andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] 
            && [defaults objectForKey:@"FBExpirationDateKey"]) {
            facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        
    }
    return self;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void) request:(FBRequest *)request didFailWithError:(NSError *)error{
    
	NSLog(@"ResponseFailed: %@", error);
	
	if ([self.delegate respondsToSelector:@selector(failedToPublishPost:)])
		[self.delegate failedToPublishPost:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)request:(FBRequest *)request didLoad:(id)result{

    self.parsedResult = result;
    if ([self.delegate respondsToSelector:@selector(finishedPublishingPost:)]){
        [self.delegate finishedPublishingPost:self];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) sendRequestWithDelegate:(id)_delegate andParams:(NSMutableDictionary *)para
{
    self.delegate=_delegate;
    //[facebook requestWithGraphPath:graphUrl andParams:para andDelegate:self];
    [facebook requestWithGraphPath:graphUrl andParams:para andHttpMethod:@"POST" andDelegate:self];
}

- (void) sendRequestWithDelegate: (id) _delegate{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.delegate = _delegate;
    [facebook requestWithGraphPath:graphUrl andDelegate:self];
}

-(void) dealloc
{
    [facebook release];
    [graphUrl release];
    [delegate release];
    [super release];
}

@end
