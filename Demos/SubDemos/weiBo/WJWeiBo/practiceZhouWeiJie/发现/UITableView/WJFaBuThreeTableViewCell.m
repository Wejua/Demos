//
//  WJFaBuThreeTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/28.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaBuThreeTableViewCell.h"

@implementation WJFaBuThreeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //leftImgV
        UIImageView *leftImgV = [[UIImageView alloc]init];
        _leftImgV = leftImgV;
        leftImgV.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:leftImgV];
        //leftLabel
        UILabel *leftLabel = [[UILabel alloc]init];
        _leftLabel = leftLabel;
        leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        [leftLabel sizeToFit];
        [self.contentView addSubview:leftLabel];
        
        
        //rightImgV
        UIImageView *rightImgV = [[UIImageView alloc]init];
        _rightImgV = rightImgV;
        rightImgV.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:rightImgV];
        //rightLabel
        UILabel *rightLabel = [[UILabel alloc]init];
        _rightLabel = rightLabel;
        rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.textColor = [UIColor blackColor];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        [rightLabel sizeToFit];
        [self.contentView addSubview:rightLabel];
        
        //left
        [leftImgV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
        [leftImgV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:15].active = YES;
        [leftImgV.widthAnchor constraintEqualToConstant:20].active = YES;
        [leftImgV.heightAnchor constraintEqualToConstant:20].active = YES;
        
        [leftLabel.leftAnchor constraintEqualToAnchor:leftImgV.rightAnchor constant:2].active = YES;
        [leftLabel.centerYAnchor constraintEqualToAnchor:leftImgV.centerYAnchor].active = YES;
        
        //right
        [rightImgV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
        [rightImgV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:[UIScreen mainScreen].bounds.size.width/2 + 15].active = YES;
        [rightImgV.widthAnchor constraintEqualToConstant:20].active = YES;
        [rightImgV.heightAnchor constraintEqualToConstant:20].active = YES;
        
        [rightLabel.leftAnchor constraintEqualToAnchor:rightImgV.rightAnchor constant:2].active = YES;
        [rightLabel.centerYAnchor constraintEqualToAnchor:rightImgV.centerYAnchor].active = YES;
        
    }
    return self;
}

@end
