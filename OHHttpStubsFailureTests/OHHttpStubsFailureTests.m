//
//  OHHttpStubsFailureTests.m
//  OHHttpStubsFailureTests
//
//  Created by Robert Ross on 12/30/13.
//  Copyright (c) 2013 Creative Queries. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "Client.h"

@interface OHHttpStubsFailureTests : XCTestCase

@end

@implementation OHHttpStubsFailureTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatOHHTTPStubsDoesNotStub // lol
{
    Client *client = [Client sharedClient];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"response.json", nil) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
    }];
    
    __block BOOL stubHit = NO;
    
    [client retrieveAnythingWithSuccess:^(id response) {
        NSString *something = response[@"something"];
        if([something isEqualToString:@"cool"]){
            stubHit = YES;
        }
    } failure:^(NSError *error) {
        stubHit = NO;
    }];
    
    expect(stubHit).will.beTruthy();
}


@end
