//
//  FKViewControllerTests.m
//  Asteroid
//
//  Created by Fredrik on 11/05/14.
//  Copyright (c) 2014 Fredrik K. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FKViewControllerTests : XCTestCase

@end

@implementation FKViewControllerTests

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

- (void)testFKModalViewControllerDoneActionCallsDelegate
{
    FKAboutController *controller = [[FKAboutController alloc] init];
    
    id viewMock = [OCMockObject mockForClass:[FKViewController class]];
    controller.delegate = viewMock;
    [[viewMock expect] addViewControllerDidSave:controller];
    
    
    [controller done:viewMock];
    
    [viewMock verify];
}

- (void)testFKModalViewControllerCancelActionCallsDelegate
{
    FKAboutController *controller = [[FKAboutController alloc] init];
    
    id viewMock = [OCMockObject mockForClass:[FKViewController class]];
    controller.delegate = viewMock;
    [[viewMock expect] addViewControllerDidCancel:controller];
    
    
    [controller cancel:viewMock];
    
    [viewMock verify];
}

- (void)testFKModalViewControllerViewDidLoad
{
    TestFKModalViewController *controller = [[TestFKModalViewController alloc] init];
    
    [controller viewDidLoad];
    STAssertTrue(superWasCalled, @"super not called");
}

- (void)testFKModalViewControllerDidReceiveMemoryWarning
{
    TestFKModalViewController *controller = [[TestFKModalViewController alloc] init];
    
    [controller didReceiveMemoryWarning];
    STAssertTrue(superWasCalled, @"super not called");
}

@end
