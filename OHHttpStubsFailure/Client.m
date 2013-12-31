//
//  Client.m
//  OHHttpStubsFailure
//
//  Created by Robert Ross on 12/30/13.
//  Copyright (c) 2013 Creative Queries. All rights reserved.
//

#import "Client.h"

@implementation Client

+ (instancetype)sharedClient {
    static Client *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@"https://itunes.apple.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _sharedClient = [[Client alloc] initWithBaseURL:baseUrl
                                         sessionConfiguration:config];
    });
    
    NSLog(@"Shared Client: %@", _sharedClient);
    
    return _sharedClient;
}

- (void)retrieveAnythingWithSuccess:(Success)success failure:(Failure)failure {
    [self GET:@"/search" parameters:@{ @"term": @"Nickelback" } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

@end
