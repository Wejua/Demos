//
//  WJWoTwoTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoTwoTableViewCell.h"

@interface WJButton:UIButton
@property(weak,nonatomic)UILabel *topLabel;
@property(weak,nonatomic)UILabel *bottomLabel;
@end
@implementation WJButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        //topLabel
        UILabel *topLabel = [[UILabel alloc]init];
        _topLabel = topLabel;
        topLabel.translatesAutoresizingMaskIntoConstraints = NO;
        topLabel.text = @"2";
        topLabel.font = [UIFont systemFontOfSize:17];
        topLabel.textColor = [UIColor blackColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        [topLabel sizeToFit];
        [self addSubview:topLabel];
        //bottomLabel
        UILabel *bottomLabel = [[UILabel alloc]init];
        _bottomLabel = bottomLabel;
        bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
        bottomLabel.text = @"微博";
        bottomLabel.font = [UIFont systemFontOfSize:14];
        bottomLabel.textColor = [UIColor grayColor];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        [bottomLabel sizeToFit];
        [self addSubview:bottomLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_topLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_topLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_topLabel.widthAnchor constraintEqualToConstant:50].active = YES;
    [_topLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    
    [_bottomLabel.topAnchor constraintEqualToAnchor:_topLabel.bottomAnchor constant:space].active = YES;
    [_bottomLabel.centerXAnchor constraintEqualToAnchor:_topLabel.centerXAnchor].active = YES;
    [_bottomLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}
@end
@implementation WJWoTwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //微博
        WJButton *weiBoBtn = [[WJButton alloc]init];
        weiBoBtn.translatesAutoresizingMaskIntoConstraints = NO;
        self.weiBoBtn = weiBoBtn;
        [weiBoBtn addTarget:self action:@selector(weiboClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:weiBoBtn];
        //关注
        WJButton *guanZhuBtn = [[WJButton alloc]init];
        guanZhuBtn.translatesAutoresizingMaskIntoConstraints = NO;
        self.guanZhuBtn = guanZhuBtn;
        [guanZhuBtn addTarget:self action:@selector(guanZhuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:guanZhuBtn];
        guanZhuBtn.topLabel.text = @"49";
        guanZhuBtn.bottomLabel.text = @"关注";
        
        //粉丝
        WJButton *fenSiBtn = [[WJButton alloc]init];
        fenSiBtn.translatesAutoresizingMaskIntoConstraints = NO;
        self.fenSiBtn = fenSiBtn;
        [fenSiBtn addTarget:self action:@selector(fenSiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:fenSiBtn];
        fenSiBtn.topLabel.text = @"7";
        fenSiBtn.bottomLabel.text = @"粉丝";
    }
    return self;
}
-(void)weiboClick{
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
-(void)guanZhuBtnClick{
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
-(void)fenSiBtnClick{
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //weibo guanzhu fensi
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_weiBoBtn]-(>=5)-[_guanZhuBtn]-(>=5)-[_fenSiBtn]-50-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"_weiBoBtn":_weiBoBtn,@"_guanZhuBtn":_guanZhuBtn,@"_fenSiBtn":_fenSiBtn}]];
    [_weiBoBtn.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [_guanZhuBtn.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
