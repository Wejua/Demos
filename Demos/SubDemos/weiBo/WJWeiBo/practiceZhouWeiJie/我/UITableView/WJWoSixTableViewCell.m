//
//  WJWoSixTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoSixTableViewCell.h"

@implementation WJWoSixTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //流量
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mianliuliang"]];
        _imgV = imgV;
        imgV.translatesAutoresizingMaskIntoConstraints = NO;
        [imgV sizeToFit];
        [self.contentView addSubview:imgV];
        //label
        UILabel *title = [[UILabel alloc]init];
        _title = title;
        title.translatesAutoresizingMaskIntoConstraints = NO;
        title.text = @"免流量";
        title.font = [UIFont systemFontOfSize:17];
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentLeft;
        [title sizeToFit];
        [self.contentView addSubview:title];
        //detail
        UILabel *detail = [[UILabel alloc]init];
        _detail = detail;
        detail.translatesAutoresizingMaskIntoConstraints = NO;
        detail.text = @"流量免费任性玩";
        detail.font = [UIFont systemFontOfSize:12];
        detail.textColor = [UIColor grayColor];
        detail.textAlignment = NSTextAlignmentLeft;
        [detail sizeToFit];
        [self.contentView addSubview:detail];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_imgV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_imgV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    
    [_title.centerYAnchor constraintEqualToAnchor:_imgV.centerYAnchor].active = YES;
    [_title.leftAnchor constraintEqualToAnchor:_imgV.rightAnchor constant:insets].active = YES;
    
    [_detail.centerYAnchor constraintEqualToAnchor:_imgV.centerYAnchor].active = YES;
    [_detail.leftAnchor constraintEqualToAnchor:_title.rightAnchor constant:insets].active = YES;
    [_detail.rightAnchor constraintLessThanOrEqualToAnchor:self.contentView.rightAnchor constant:-insets].active = YES;
    
}

@end
