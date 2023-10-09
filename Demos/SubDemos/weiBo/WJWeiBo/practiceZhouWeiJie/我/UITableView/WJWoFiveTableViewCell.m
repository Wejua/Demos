//
//  WJWoFiveTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoFiveTableViewCell.h"

@implementation WJWoFiveTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //让红包飞
        UILabel *hongBaoFei = [[UILabel alloc]init];
        _hongBaoFei = hongBaoFei;
        hongBaoFei.translatesAutoresizingMaskIntoConstraints = NO;
        hongBaoFei.text = @"让红包飞";
        hongBaoFei.font = [UIFont systemFontOfSize:12];
        hongBaoFei.textColor = [UIColor grayColor];
        hongBaoFei.textAlignment = NSTextAlignmentLeft;
        [hongBaoFei sizeToFit];
        [self.contentView addSubview:hongBaoFei];
        //meiYouQiang
        UILabel *meiYouQiang = [[UILabel alloc]init];
        _meiYouQiang = meiYouQiang;
        meiYouQiang.translatesAutoresizingMaskIntoConstraints = NO;
        meiYouQiang.text = @"这里有现金红包你还没有抢";
        meiYouQiang.font = [UIFont systemFontOfSize:15];
        meiYouQiang.textColor = [UIColor blackColor];
        meiYouQiang.textAlignment = NSTextAlignmentLeft;
        [meiYouQiang sizeToFit];
        [self.contentView addSubview:meiYouQiang];
        //img
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"linghongbao"]];
        _imgV = imgV;
        imgV.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:imgV];
        //抢红包
        UILabel *qiangHB = [[UILabel alloc]init];
        _qiangHB = qiangHB;
        qiangHB.translatesAutoresizingMaskIntoConstraints = NO;
        qiangHB.text = @"抢红包";
        qiangHB.font = [UIFont systemFontOfSize:17];
        qiangHB.textColor = [UIColor colorWithRed:77/255.0 green:129/255.0 blue:174/255.0 alpha:1.0];
        qiangHB.textAlignment = NSTextAlignmentCenter;
        [qiangHB sizeToFit];
        [self.contentView addSubview:qiangHB];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_hongBaoFei.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_hongBaoFei.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    
    [_meiYouQiang.topAnchor constraintEqualToAnchor:_hongBaoFei.bottomAnchor constant:insets].active = YES;
    [_meiYouQiang.leftAnchor constraintEqualToAnchor:_hongBaoFei.leftAnchor].active = YES;
    
    [_imgV.leftAnchor constraintEqualToAnchor:_meiYouQiang.leftAnchor].active = YES;
    [_imgV.topAnchor constraintEqualToAnchor:_meiYouQiang.bottomAnchor constant:insets].active = YES;
    [_imgV.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-insets].active = YES;
    
    [_qiangHB.topAnchor constraintEqualToAnchor:_imgV.bottomAnchor constant:insets*2].active = YES;
    [_qiangHB.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [_qiangHB.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-insets].active = YES;
    [_qiangHB.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
}

@end
