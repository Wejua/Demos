//
//  WJActivityView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/28.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "WJActivityView.h"

@implementation WJActivityView
+(void)show{
    [[self sharedInstance] startAnimating];
}
+(void)dismiss{
    [[self sharedInstance] stopAnimating];
}
+(instancetype)sharedInstance{
    static WJActivityView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:instance];
        instance.center = window.center;
    });
    return instance;
}
@end
