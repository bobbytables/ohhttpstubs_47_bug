//
//  Client.h
//  OHHttpStubsFailure
//
//  Created by Robert Ross on 12/30/13.
//  Copyright (c) 2013 Creative Queries. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface Client : AFHTTPSessionManager

typedef void(^Success)(id response);
typedef void(^Failure)(NSError *error);

+ (instancetype)sharedClient;
- (void)retrieveAnythingWithSuccess:(Success)success
                            failure:(Failure)failure;

@end
