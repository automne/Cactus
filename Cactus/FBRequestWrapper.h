//
//  FBRequestWrapper.h
//  Cactus
//
//  Created by Automne on 12/30/11.
//  Copyright (c) 2011 Automne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
@protocol FBRequestWrapperDelegate;

@interface FBRequestWrapper : NSObject <FBRequestDelegate, FBSessionDelegate>
{
    Facebook *facebook;
    NSString *graphUrl;
    id parsedResult;
    id <FBRequestWrapperDelegate> delegate;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSString *graphUrl;
@property (nonatomic, retain) id parsedResult;
@property (nonatomic, assign) id <FBRequestWrapperDelegate> delegate;


- (id) initWithGraphPath: (NSString *) path;
- (void) sendRequestWithDelegate: (id) _delegate;
- (void) sendRequestWithDelegate:(id)_delegate andParams:(NSMutableDictionary *)para;
@end


@protocol FBRequestWrapperDelegate <NSObject>

@required
- (void) failedToPublishPost:(FBRequestWrapper*) _request;
- (void) finishedPublishingPost:(FBRequestWrapper*) _request;

@end
