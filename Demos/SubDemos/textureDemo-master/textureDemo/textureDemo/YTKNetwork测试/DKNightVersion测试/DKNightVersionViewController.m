//
//  DKNightVersionViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/29.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "DKNightVersionViewController.h"

@interface DKNightVersionViewController ()

@end

@implementation DKNightVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}


@end
