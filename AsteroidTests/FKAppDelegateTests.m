//
//  FKAppDelegateTests.m
//  Astroid
//
//  Created by Fredrik on 10/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FKAppDelegate.h"

@interface FKAppDelegateTests : XCTestCase

@end

@implementation FKAppDelegateTests

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

- (void)testFKAppDelegateApplicationDidFinishLaunchingWithOptions
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    id dicMock = [OCMockObject mockForClass:[NSDictionary class]];
    
    XCTAssertTrue([SUT application:appMock didFinishLaunchingWithOptions:dicMock],@"APP FAILED");
    
    [appMock verify];
}

- (void)testFKAppDelegateApplicationWillResignActive
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    
    [SUT applicationWillResignActive:appMock];
    
    [appMock verify];
}

- (void)testFKAppDelegateApplicationDidBecomeActive
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    
    [SUT applicationDidBecomeActive:appMock];
    
    [appMock verify];
}

- (void)testFKAppDelegateApplicationDidEnterBackground
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    
    [SUT applicationDidEnterBackground:appMock];
    
    [appMock verify];
}

- (void)testFKAppDelegateApplicationWillEnterForeground
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    
    [SUT applicationWillEnterForeground:appMock];
    
    [appMock verify];
}

- (void)testFKAppDelegateApplicationWillTerminate
{
    FKAppDelegate *SUT = [[FKAppDelegate alloc] init];
    
    id appMock = [OCMockObject mockForClass:[UIApplication class]];
    
    [SUT applicationWillTerminate:appMock];
    
    [appMock verify];
}

@end
