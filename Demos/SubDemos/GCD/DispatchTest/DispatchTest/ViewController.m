//
//  ViewController.m
//  DispatchTest
//
//  Created by weijie.zhou on 2023/7/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)test {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self requestA:^{
            NSLog(@"requestA end");
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self requestB:^{
            NSLog(@"requestB end");
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_barrier_async(queue, ^{
        [self requestC:^{
            NSLog(@"requestC end");
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_barrier_async(queue, ^{
        [self requestD:^{
            NSLog(@"requestD end");
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self function];
    });
}
- (void)requestA:(void (^)(void))completion {
    NSLog(@"requestA begin");
    [NSThread sleepForTimeInterval:2];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion != nil) {
            completion();
        }
    });
}
- (void)requestB:(void (^)(void))completion {
    NSLog(@"requestB begin");
    [NSThread sleepForTimeInterval:0.5];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion != nil) {
            completion();
        }
    });
}
- (void)requestC:(void (^)(void))completion {
    NSLog(@"requestC begin");
    [NSThread sleepForTimeInterval:3];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion != nil) {
            completion();
        }
    });
}
- (void)requestD:(void (^)(void))completion {
    NSLog(@"requestD begin");
    [NSThread sleepForTimeInterval:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (completion != nil) {
            completion();
        }
    });
}
- (void)function {
    NSLog(@"function");
}

@end
