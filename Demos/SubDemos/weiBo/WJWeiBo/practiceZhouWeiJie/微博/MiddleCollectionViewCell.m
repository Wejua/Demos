//
//  WJCollectionViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/16.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "MiddleCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@implementation MiddleCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        FLAnimatedImageView *imgV = [[FLAnimatedImageView alloc]init];
        _imgV = imgV;
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imgV];
        //长图动图
        UIImageView *changDongTuImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dongtu"]];
        _changDongTuImgV = changDongTuImgV;
        changDongTuImgV.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:changDongTuImgV];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imgV.translatesAutoresizingMaskIntoConstraints = NO;
    //top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imgV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imgV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    //bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imgV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imgV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    //头像
    [_changDongTuImgV.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [_changDongTuImgV.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [_changDongTuImgV.widthAnchor constraintEqualToConstant:30].active = YES;
    [_changDongTuImgV.heightAnchor constraintEqualToConstant:20].active = YES;
}
-(void)setModel:(NSString *)model{
    _model = model;
    NSString *newModel = [model stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:newModel] placeholderImage:[UIImage imageNamed:@"cellPlaceholdImage"]];
    //判断后缀名显示动图长图标志
    NSString *suffixName = model.pathExtension.lowercaseString;
    NSLog(@"%@",suffixName);
    if ([suffixName isEqualToString:@"gif"]) {
        _changDongTuImgV.image = [UIImage imageNamed:@"dongtu"];
        _changDongTuImgV.hidden = NO;
//        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newModel]]];
//        _imgV.animatedImage = image;
        
    }else{
        _changDongTuImgV.hidden = YES;
//        [_imgV sd_setImageWithURL:[NSURL URLWithString:newModel] placeholderImage:[UIImage imageNamed:@"cellPlaceholdImage"]];
    }
}
@end
