//
//  WJHaiMeiYouTongZhiView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/23.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJHaiMeiYouTongZhiView.h"

@implementation WJHaiMeiYouTongZhiView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //titleImageV
        UIImageView *titleImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"haiMeiYouTongZhi"]];
        _titleImgV = titleImgV;
        [self addSubview:titleImgV];
        titleImgV.translatesAutoresizingMaskIntoConstraints = NO;
        //label
        UILabel *label = [[UILabel alloc]init];
        _label = label;
        label.text = @"你还没有通知";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //v
    [_label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_label sizeToFit];
    
    [_titleImgV.centerXAnchor constraintEqualToAnchor:_label.centerXAnchor].active = YES;
    [_label.topAnchor constraintEqualToAnchor:_titleImgV.bottomAnchor constant:20].active = YES;
    [_titleImgV.heightAnchor constraintEqualToConstant:55].active = YES;
    [_titleImgV.widthAnchor constraintEqualToConstant:55].active = YES;
    
    [self.topAnchor constraintEqualToAnchor:_titleImgV.topAnchor].active = YES;
    [self.leftAnchor constraintEqualToAnchor:_label.leftAnchor].active = YES;
    [self.rightAnchor constraintEqualToAnchor:_label.rightAnchor].active = YES;
}
@end
