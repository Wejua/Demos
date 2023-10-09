//
//  WJWoFourTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWoFourTableViewCell.h"

@implementation WJWoFourTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        //经常访问
        UILabel *jingChangFW = [[UILabel alloc]init];
        _jingChangFW = jingChangFW;
        jingChangFW.translatesAutoresizingMaskIntoConstraints = NO;
        jingChangFW.text = @"经常访问";
        jingChangFW.font = [UIFont systemFontOfSize:12];
        jingChangFW.textColor = [UIColor grayColor];
        jingChangFW.textAlignment = NSTextAlignmentLeft;
        [jingChangFW sizeToFit];
        [self.contentView addSubview:jingChangFW];
        //detail
        UILabel *detail = [[UILabel alloc]init];
        _detail = detail;
        detail.translatesAutoresizingMaskIntoConstraints = NO;
        detail.text = @"我最近经常访问的主页";
        detail.font = [UIFont systemFontOfSize:15];
        detail.textColor = [UIColor blackColor];
        detail.textAlignment = NSTextAlignmentLeft;
        [detail sizeToFit];
        [self.contentView addSubview:detail];
        //imgarray
        _imgNameArray = @[@"six",@"five",@"four",@"two",@"one"];
        _imgArray = [NSMutableArray array];
        for (int i = 0 ; i<5; i++) {
            UIButton *button = [[UIButton alloc]init];
            [_imgArray addObject:button];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.tag = i;
            [button setImage:[UIImage imageNamed:_imgNameArray[i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
        }
        //查看全部
        UILabel *chaKanQB = [[UILabel alloc]init];
        _chaKanQB = chaKanQB;
        chaKanQB.translatesAutoresizingMaskIntoConstraints = NO;
        chaKanQB.text = @"查看全部";
        chaKanQB.font = [UIFont systemFontOfSize:17];
        chaKanQB.textColor = [UIColor colorWithRed:77/255.0 green:129/255.0 blue:174/255.0 alpha:1.0];
        chaKanQB.textAlignment = NSTextAlignmentCenter;
        [chaKanQB sizeToFit];
        [self.contentView addSubview:chaKanQB];
    }
    return self;
}
-(void)buttonClick:(UIButton *)button{
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}

-(void)layoutSubviews{
    [_jingChangFW.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_jingChangFW.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    
    [_detail.topAnchor constraintEqualToAnchor:_jingChangFW.bottomAnchor constant:insets].active = YES;
    [_detail.leftAnchor constraintEqualToAnchor:_jingChangFW.leftAnchor].active = YES;
    
    UIButton *btn1 = _imgArray[0];
    [btn1.leftAnchor constraintEqualToAnchor:_jingChangFW.leftAnchor].active = YES;
    [btn1.topAnchor constraintEqualToAnchor:_detail.bottomAnchor constant:insets].active = YES;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-insets-[btn1(==btn2)]-[btn2(==btn3)]-[btn3(==btn4)]-[btn4(==btn5)]-[btn5]-insets-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"insets":@(insets)} views:@{@"btn1":_imgArray[0],@"btn2":_imgArray[1],@"btn3":_imgArray[2],@"btn4":_imgArray[3],@"btn5":_imgArray[4]}]];
    
    [_chaKanQB.topAnchor constraintEqualToAnchor:btn1.bottomAnchor constant:insets*2].active = YES;
    [_chaKanQB.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [_chaKanQB.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-insets].active = YES;
    [_chaKanQB.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
}
@end
