//
//  WJXiaoXiTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/21.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJXiaoXiTableViewCell.h"

@interface WJXiaoXiTableViewCell()
@property(weak,nonatomic)UIView *rightView;
@property(weak,nonatomic)UIImageView *separatorView;
@end
@implementation WJXiaoXiTableViewCell
#define cellHeight 70
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV = imageV;
        [self.contentView addSubview:imageV];
        //rightView
        UIView *rightView = [[UIView alloc]init];
        _rightView = rightView;
        [self.contentView addSubview:rightView];
        //titleLabel
        UILabel *titleLabel = [[UILabel alloc]init];
        _titleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [rightView addSubview:titleLabel];
        //detailLabel
        UILabel *detailLabel = [[UILabel alloc]init];
        _detailLabel = detailLabel;
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        [rightView addSubview:detailLabel];
        //timeLabel
        UILabel *timeLabel = [[UILabel alloc]init];
        _timeLabel = timeLabel;
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLabel];
        //separatorView
        UIImageView *separatorView = [[UIImageView alloc]init];
        _separatorView = separatorView;
        separatorView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        separatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:separatorView];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imgV.translatesAutoresizingMaskIntoConstraints = NO;
    _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_imgV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_imgV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    [_imgV.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-insets].active = YES;
    [_imgV.rightAnchor constraintEqualToAnchor:_rightView.leftAnchor constant:-insets].active = YES;
    [_imgV.heightAnchor constraintEqualToAnchor:_imgV.widthAnchor].active = YES;
    
    //rightView
    [_rightView.centerYAnchor constraintEqualToAnchor:_imgV.centerYAnchor].active = YES;
    [_rightView.topAnchor constraintEqualToAnchor:_titleLabel.topAnchor].active = YES;
    [_rightView.leftAnchor constraintEqualToAnchor:_imgV.rightAnchor constant:insets].active = YES;
    [_rightView.bottomAnchor constraintEqualToAnchor:_detailLabel.bottomAnchor].active = YES;
    [_rightView.rightAnchor constraintEqualToAnchor:_timeLabel.leftAnchor constant:-space].active = YES;
    
    //timeLabel
    [_timeLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_timeLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-insets].active = YES;
    
    //titleLabel
    [_titleLabel.topAnchor constraintEqualToAnchor:_rightView.topAnchor].active = YES;
    [_titleLabel.leftAnchor constraintEqualToAnchor:_rightView.leftAnchor].active = YES;
    
    //detailLabel
    [_detailLabel.leftAnchor constraintEqualToAnchor:_rightView.leftAnchor].active = YES;
    [_detailLabel.bottomAnchor constraintEqualToAnchor:_rightView.bottomAnchor].active = YES;
    [_detailLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:space].active = YES;
    
    //separatorView
    [_separatorView.leftAnchor constraintEqualToAnchor:_rightView.leftAnchor].active = YES;
    [_separatorView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [_separatorView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [_separatorView.heightAnchor constraintEqualToConstant:1].active = YES;
    
}
@end
