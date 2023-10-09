//
//  WJWoThreeTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoThreeTableViewCell.h"

@interface WJTopImgButton:UIButton
@end
@implementation WJTopImgButton
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.widthAnchor constraintEqualToConstant:25].active = YES;
    [self.imageView.heightAnchor constraintEqualToConstant:25].active = YES;
    
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 15);
    self.imageView.center = CGPointMake(midX, midY - 15);
}
@end

@implementation WJWoThreeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _buttonArray = [NSMutableArray array];
        _imgNameArray = @[@"haoyou",@"xiangceWo",@"zanxiaoxin",@"fensifuwu",@"qianbao",@"yundong",@"toutiao",@"kefuzhongxin"];
        _titleArray = @[@"新的好友",@"我的相册",@"我的赞",@"粉丝服务",@"微博钱包",@"微博运动",@"粉丝头条",@"客服中心"];
        for (int i =0; i<8; i++) {
            WJTopImgButton *button = [WJTopImgButton buttonWithType:UIButtonTypeCustom];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            [button setImage:[UIImage imageNamed:_imgNameArray[i]] forState:UIControlStateNormal];
            [button setTitle:_titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
            [_buttonArray addObject:button];
            [self.contentView addSubview:button];
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //1,2,3,4
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[btn0(==btn1)]-[btn1(==btn2)]-[btn2(==btn3)]-[btn3]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"btn0":_buttonArray[0],@"btn1":_buttonArray[1],@"btn2":_buttonArray[2],@"btn3":_buttonArray[3]}]];
    //5,6,7,8
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[btn5(==btn6)]-[btn6(==btn7)]-[btn7(==btn8)]-[btn8]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"btn5":_buttonArray[4],@"btn6":_buttonArray[5],@"btn7":_buttonArray[6],@"btn8":_buttonArray[7]}]];
    //1,5
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[btn0(==btn4)]-[btn4]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"btn0":_buttonArray[0],@"btn4":_buttonArray[4]}]];
}
@end
