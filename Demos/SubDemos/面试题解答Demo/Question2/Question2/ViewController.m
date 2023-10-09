//
//  ViewController.m
//  Question2
//
//  Created by weijie.zhou on 2023/7/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *scores1 = @[@100, @56, @87, @45, @90, @88, @93, @90, @60, @65, @76, @77, @75, @88, @75];
    NSArray *scores2 = @[@100, @56, @87, @45, @90, @80];
    NSArray *scores3 = @[@100, @56, @87];
    int score = [self test:scores2];
    NSLog(@"%d", score);
}

- (int)test:(NSArray *)scores {
    NSUInteger studentCount = scores.count;
    //从小到大排序
    NSArray *sortedArray = [scores sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 intValue] < [obj2 intValue]) {
            return NSOrderedAscending;
        } else if ([obj1 intValue] > [obj2 intValue]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    //学生个数小于等于三的情况
    if (studentCount <= 3) {
        NSUInteger index = studentCount - 1;
        if ([sortedArray[index] intValue] % 10 == 0) {
            return [sortedArray[index] intValue];
        } else {
            //不存在返回-1
            return -1;
        }
    }
    
    //找到及格线位置，是小数则向上取整
    int index = ceilf(studentCount / 10.0 * 6.0);
    //如果不是10的倍数，向后取
    for (int i = index; i < studentCount; i++) {
        int score = [sortedArray[i] intValue];
        BOOL r = (score % 10) != 0;
        if (r) {
            continue;
        } else {
            int score = [sortedArray[i] intValue];
            return score;
        }
    }
    //百分之六十后一直没有10的倍数，返回-1
    return -1;
}

@end
