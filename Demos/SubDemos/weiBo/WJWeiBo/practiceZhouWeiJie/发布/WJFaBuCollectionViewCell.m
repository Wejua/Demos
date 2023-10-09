//
//  WJFaBuCollectionViewCell.m
//  模糊效果
//
//  Created by WJMac on 2018/2/27.
//  Copyright © 2018年 WJMac. All rights reserved.
//

#import "WJFaBuCollectionViewCell.h"

@implementation WJFaBuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView  = imgv;
        [self addSubview: imgv];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel  = titleLabel;
        [self addSubview: titleLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    
    [self.titleLabel sizeToFit];
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor].active = YES;
    
}
@end
