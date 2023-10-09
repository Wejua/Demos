//
//  AnimationWithInteractionTests.m
//  AnimationWithInteractionTests
//
//  Created by 周位杰 on 2021/6/17.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"
#import "AppDelegate.h"

@interface AnimationWithInteractionTests : XCTestCase
{
    UIApplication *app;
    AppDelegate *AppDelegate;
    UIViewController *viewController;
    UIView *view;
}

@end

@implementation AnimationWithInteractionTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    app = [UIApplication sharedApplication];
    viewController = nil;
    view = viewController.view;
}

- (void)testdname {
    XCTAssertNil(nil,@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
