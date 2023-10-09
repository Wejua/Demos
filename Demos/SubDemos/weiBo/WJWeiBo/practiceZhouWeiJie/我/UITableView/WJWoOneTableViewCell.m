//
//  WJWoOneTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/24.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoOneTableViewCell.h"

@implementation WJWoOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //头像
        UIButton *touXiangBtn = [[UIButton alloc]init];
        touXiangBtn.translatesAutoresizingMaskIntoConstraints = NO;
        self.touXiangBtn = touXiangBtn;
        [touXiangBtn setImage:[UIImage imageNamed:@"touxiao"] forState:UIControlStateNormal];
        [touXiangBtn sizeToFit];
        [touXiangBtn addTarget:self action:@selector(touXiangClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:touXiangBtn];
        //头像detailView
        UIView *touXiangDetailView = [[UIView alloc]init];
        _touXiangDetailView = touXiangDetailView;
        touXiangDetailView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:touXiangDetailView];
        //touXiangDetailTitle
        UILabel *touXiangDetailViewTitle = [[UILabel alloc]init];
        touXiangDetailViewTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _touXiangDetailViewTitle = touXiangDetailViewTitle;
        touXiangDetailViewTitle.text = @"lujieyilujieyi";
        touXiangDetailViewTitle.font = [UIFont boldSystemFontOfSize:18];
        touXiangDetailViewTitle.textColor = [UIColor blackColor];
        touXiangDetailViewTitle.textAlignment = NSTextAlignmentLeft;
        [touXiangDetailViewTitle sizeToFit];
        [_touXiangDetailView addSubview:touXiangDetailViewTitle];
        //简介
        UILabel *touXiangDetailViewJianJie = [[UILabel alloc]init];
        touXiangDetailViewJianJie.translatesAutoresizingMaskIntoConstraints = NO;
        _touXiangDetailViewJianJie = touXiangDetailViewJianJie;
        touXiangDetailViewJianJie.text = @"简介:";
        touXiangDetailViewJianJie.font = [UIFont systemFontOfSize:12];
        touXiangDetailViewJianJie.textColor = [UIColor grayColor];
        touXiangDetailViewJianJie.textAlignment = NSTextAlignmentLeft;
        [touXiangDetailViewJianJie sizeToFit];
        [_touXiangDetailView addSubview:touXiangDetailViewJianJie];
        //介绍
        UILabel *touXiangDetailViewJieShao = [[UILabel alloc]init];
        touXiangDetailViewJieShao.translatesAutoresizingMaskIntoConstraints = NO;
        _touXiangDetailViewJieShao = touXiangDetailViewJieShao;
        touXiangDetailViewJieShao.text = @"暂无介绍";
        touXiangDetailViewJieShao.font = [UIFont systemFontOfSize:12];
        touXiangDetailViewJieShao.textColor = [UIColor grayColor];
        touXiangDetailViewJieShao.textAlignment = NSTextAlignmentLeft;
        [touXiangDetailViewJieShao sizeToFit];
        [_touXiangDetailView addSubview:touXiangDetailViewJieShao];
        //会员图片
        UIImageView *huiYuanImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huangguan"]];
        huiYuanImgV.translatesAutoresizingMaskIntoConstraints = NO;
        _huiYuanImgV = huiYuanImgV;
        [huiYuanImgV sizeToFit];
        [self.contentView addSubview:huiYuanImgV];
        //会员label
        UILabel *huiYuanLabel = [[UILabel alloc]init];
        huiYuanLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _huiYuanLabel = huiYuanLabel;
        huiYuanLabel.text = @"会员";
        huiYuanLabel.font = [UIFont systemFontOfSize:15];
        huiYuanLabel.textColor = [UIColor orangeColor];
        huiYuanLabel.textAlignment = NSTextAlignmentLeft;
        [huiYuanLabel sizeToFit];
        [self.contentView addSubview:huiYuanLabel];
        //箭头图片
        UIImageView *jianTouImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
        jianTouImgV.translatesAutoresizingMaskIntoConstraints = NO;
        _jianTouImgV = jianTouImgV;
        [jianTouImgV sizeToFit];
        [self.contentView addSubview:jianTouImgV];
    }
    return self;
}
-(void)layoutSubviews{
//    [super layoutSubviews];
    //头像
    [_touXiangBtn.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_touXiangBtn.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    [_touXiangBtn.widthAnchor constraintEqualToConstant:60].active = YES;
    [_touXiangBtn.heightAnchor constraintEqualToConstant:60].active = YES;
    
    //_touXiangDetailViewTitle
    [_touXiangDetailViewTitle.leftAnchor constraintEqualToAnchor:_touXiangDetailView.leftAnchor].active = YES;
    [_touXiangDetailViewTitle.bottomAnchor constraintEqualToAnchor:_touXiangDetailViewJianJie.topAnchor constant:-space].active = YES;
    //_touXiangDetailViewJianJie
    [_touXiangDetailViewJianJie.leftAnchor constraintEqualToAnchor:_touXiangDetailView.leftAnchor].active = YES;
    //_touXiangDetailViewJieShao
    [_touXiangDetailViewJieShao.topAnchor constraintEqualToAnchor:_touXiangDetailViewJianJie.topAnchor].active = YES;
    [_touXiangDetailViewJieShao.leftAnchor constraintEqualToAnchor:_touXiangDetailViewJianJie.rightAnchor].active = YES;
    //touxiangdetailv
    [_touXiangDetailView.topAnchor constraintEqualToAnchor:_touXiangDetailViewTitle.topAnchor].active = YES;
    [_touXiangDetailView.leftAnchor constraintEqualToAnchor:_touXiangBtn.rightAnchor constant:insets].active = YES;
    [_touXiangDetailView.bottomAnchor constraintEqualToAnchor:_touXiangDetailViewJianJie.bottomAnchor].active = YES;
    [_touXiangDetailView.rightAnchor constraintEqualToAnchor:_huiYuanImgV.leftAnchor constant:-insets].active = YES;
    [_touXiangDetailView.centerYAnchor constraintEqualToAnchor:_touXiangBtn.centerYAnchor].active = YES;
    
    //_huiYuanImgV
    [_huiYuanImgV.centerYAnchor constraintEqualToAnchor:_touXiangBtn.centerYAnchor].active = YES;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_huiYuanImgV]-(==2)-[_huiYuanLabel]-(==2)-[_jianTouImgV]-insets-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"insets":@(insets)} views:@{@"_huiYuanImgV":_huiYuanImgV,@"_huiYuanLabel":_huiYuanLabel,@"_jianTouImgV":_jianTouImgV}]];
    //contentView
//    [self.contentView.bottomAnchor constraintGreaterThanOrEqualToAnchor:_touXiangBtn.bottomAnchor constant:insets].active = YES;
}
-(void)touXiangClick{
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
