//
//  JYNavigationViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/26.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYNavigationViewController.h"

@interface JYNavigationViewController ()

@end

@implementation JYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置中间title文字的大小和颜色（也可以直接用appearanc，别人说会有问题）
    UINavigationBar *navigtionBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    [navigtionBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //改变两边item字体的大小和颜色
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateHighlighted];

}

@end
