//
//  ViewController.m
//  dyldTest
//
//  Created by 周位杰 on 2022/1/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)load {
    NSLog(@"\nViewController的load方法来了");
}

__attribute__((constructor)) void func1() {
    printf("__attribute__ func1 来了\n");
}

__attribute__((constructor)) void func2() {
    printf("__attribute__ func2 来了\n");
}

__attribute__((constructor)) void func3() {
    printf("__attribute__ func3 来了\n");
}

@end
