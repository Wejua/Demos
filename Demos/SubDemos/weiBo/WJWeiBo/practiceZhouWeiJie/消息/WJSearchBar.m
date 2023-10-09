//
//  WJSearchBar.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/22.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJSearchBar.h"
@interface WJSearchBar()
@end
@implementation WJSearchBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.placeholder = @"搜索";
        //画图片设置searchBar背景
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 45);
        UIColor *color = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        UIGraphicsBeginImageContext(size);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setBackgroundImage:image];
        //设置放大境图片
        [self setImage:[UIImage imageNamed:@"fangDaJing"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //KVC修改placeholder字体的颜色和大小
        UITextField * searchField = [self valueForKey:@"_searchField"];
        [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        //设置text偏移量，往右一点
        [self setSearchTextPositionAdjustment:UIOffsetMake(5, 0)];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //改textField高度
    UIView *field = self.subviews[0].subviews[1];
    field.frame = CGRectMake(8, 9.5, 398, 26);
    //改掉背景圆角
    for (UIView *subView in field.subviews) {
        if([NSStringFromClass(subView.class) isEqualToString:@"_UISearchBarSearchFieldBackgroundView"]){
            subView.clipsToBounds = NO;
            subView.backgroundColor = [UIColor whiteColor];
            subView.layer.cornerRadius = 4;
        }
    }
}
@end
