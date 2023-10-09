//
//  WJShiPinBottomView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/17.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJShiPinBottomView.h"

@implementation WJShiPinBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //portraitImgV
        UIImageView *portraitImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touXiang"]];
        _portraitImgV = portraitImgV;
        portraitImgV.translatesAutoresizingMaskIntoConstraints = NO;
        [portraitImgV sizeToFit];
        [self addSubview:portraitImgV];
        //portraitDetailLable
        UILabel *portraitDetailLable = [[UILabel alloc]init];
        _portraitDetailLable = portraitDetailLable;
        portraitDetailLable.translatesAutoresizingMaskIntoConstraints = NO;
        portraitDetailLable.text = @"song jingjing";
        portraitDetailLable.font = [UIFont systemFontOfSize:15];
        portraitDetailLable.textColor = [UIColor lightGrayColor];
        portraitDetailLable.textAlignment = NSTextAlignmentLeft;
        [portraitDetailLable sizeToFit];
        [self addSubview:portraitDetailLable];
        //pingLun
        UIImageView *pingLun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pingLun"]];
        _pingLun = pingLun;
        pingLun.translatesAutoresizingMaskIntoConstraints = NO;
        [pingLun sizeToFit];
        [self addSubview:pingLun];
        //fenXiang
        UIImageView *fenXiang = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lianJie"]];
        _fenXiang = fenXiang;
        fenXiang.translatesAutoresizingMaskIntoConstraints = NO;
        [fenXiang sizeToFit];
        [self addSubview:fenXiang];
        //zanImgV
        UIImageView *zanImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"]];
        _zanImgV = zanImgV;
        zanImgV.translatesAutoresizingMaskIntoConstraints = NO;
        [zanImgV sizeToFit];
        [self addSubview:zanImgV];
        //zanLabel
        UILabel *zanLabel = [[UILabel alloc]init];
        _zanLabel = zanLabel;
        zanLabel.translatesAutoresizingMaskIntoConstraints = NO;
        zanLabel.text = @"244";
        zanLabel.font = [UIFont systemFontOfSize:13];
        zanLabel.textColor = [UIColor lightGrayColor];
        zanLabel.textAlignment = NSTextAlignmentLeft;
        [zanLabel sizeToFit];
        [self addSubview:zanLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
    //_portraitImgV
    [_portraitImgV.topAnchor constraintEqualToAnchor:self.topAnchor constant:insets].active = YES;
    [_portraitImgV.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    [_portraitImgV.widthAnchor constraintEqualToConstant:30].active = YES;
    [_portraitImgV.heightAnchor constraintEqualToConstant:30].active = YES;
    [_portraitImgV.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-insets].active = YES;
    //_portraitDetailLable
    [_portraitDetailLable.leftAnchor constraintEqualToAnchor:_portraitImgV.rightAnchor constant:insets].active = YES;
    [_portraitDetailLable.centerYAnchor constraintEqualToAnchor:_portraitImgV.centerYAnchor].active = YES;
    
    //pinglun
    [_pingLun.centerYAnchor constraintEqualToAnchor:_portraitImgV.centerYAnchor].active = YES;
    //bottomRight
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_pingLun]-25-[_fenXiang]-25-[_zanImgV]-5-[_zanLabel]-30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"_pingLun":_pingLun,@"_fenXiang":_fenXiang,@"_zanImgV":_zanImgV,@"_zanLabel":_zanLabel}]];
}

@end
