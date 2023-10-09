//
//  main.m
//  queue
//
//  Created by weijie.zhou on 2023/7/10.
//

#import <Foundation/Foundation.h>

@interface TestObject: NSObject
- (void)test;
@end
@implementation TestObject

- (void)test {
    dispatch_queue_t concurrentQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"requesccc");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self requestA];
        });
    });
    dispatch_async(concurrentQ, ^{
        NSLog(@"ddd");
        [self requestB];
    });
//    dispatch_barrier_async(concurrentQ, ^{
//        [self requestC];
//        [self requestD];
//    });
    dispatch_async(concurrentQ, ^{
        NSLog(@"eee");
        [self function];
    });
}

- (void)requestA {
//    [NSThread sleepForTimeInterval:1];
    NSLog(@"requestA");
}

- (void)requestB {
//    [NSThread sleepForTimeInterval:1];
    NSLog(@"requestB");
}

- (void)requestC {
//    [NSThread sleepForTimeInterval:1];
    NSLog(@"requestC");
}

- (void)requestD {
//    [NSThread sleepForTimeInterval:1];
    NSLog(@"requestD");
}

- (void)function {
//    [NSThread sleepForTimeInterval:1];
    NSLog(@"function");
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        dispatch_async(queue, ^{
            dispatch_queue_main_t mainQ = dispatch_get_main_queue();
            dispatch_async(mainQ, ^{
                printf("ccc");
            });
        });
//        [[TestObject new] test];
    }
    return 0;
}

