//
//  AlertViewController.m
//  LoginAlertDemo
//
//  Created by tommy on 15/12/9.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "HTItunesCommentViewControllent.h"


#define screenS [UIScreen mainScreen].bounds.size
#define labelLeading [UIScreen mainScreen].bounds.size.height/29.44
#define lineMagin [UIScreen mainScreen].bounds.size.height/29.44
#define goodBtnHeight [UIScreen mainScreen].bounds.size.height/14.72
#define textSize [UIScreen mainScreen].bounds.size.height/43.294
#define ViewHeight [UIScreen mainScreen].bounds.size.height/16
#define textY ViewHeight/3.636


#warning
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HTItunesCommentViewControllent ()
@property (nonatomic,weak)UIButton *btn2;
@property (nonatomic,weak)UIButton *btn3;
@property (nonatomic,weak)UIView *contentV;
@property (nonatomic,assign)int IndexBtn;

@end

@implementation HTItunesCommentViewControllent

- (void)viewDidLoad {
    [super viewDidLoad];
    self.IndexBtn = 1;
    //遮罩
    UIImageView *mask = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0.5;
    [self.view addSubview: mask];
    
    //contentV
    CGFloat leading = screenS.width/11.8;
    CGFloat topPadding = screenS.height/5.66;
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(leading, topPadding,screenS.width-leading*2, screenS.height-topPadding*2)];
    [self.view addSubview:contentV];
    contentV.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.contentV = contentV;
    contentV.backgroundColor = [UIColor whiteColor];

    
    //image
    UIImageView *topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"itunes_comment_top"]];
    topImg.frame = CGRectMake(0, -20, contentV.bounds.size.width, contentV.bounds.size.height/2.3);
    [contentV addSubview:topImg];
    //1
    UILabel *V1 = [[UILabel alloc]init];
    V1.text = @"请您发自肺腑的表达一下";
    V1.font = [UIFont systemFontOfSize:textSize];
    V1.frame = CGRectMake(labelLeading, CGRectGetMaxY(topImg.frame)+15,0 , 0);
    [V1 setTextColor:UIColorFromRGB(0x575757)];
    [V1 sizeToFit];
    [contentV addSubview:V1];
    
    //2
    UILabel *V2 = [[UILabel alloc]init];
    V2.text = @"喜悦的心情吧！";
    V2.font = [UIFont systemFontOfSize:textSize];
    V2.frame = CGRectMake(labelLeading, CGRectGetMaxY(V1.frame)+5,0 , 0);
    [V2 setTextColor:UIColorFromRGB(0x575757)];
    [V2 sizeToFit];
    [contentV addSubview:V2];
    
    //3
    UIView *view1= [[UIView alloc]initWithFrame:CGRectMake(labelLeading, CGRectGetMaxY(V2.frame)+lineMagin, contentV.bounds.size.width-labelLeading*2, ViewHeight)];
    //button
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"itunes_comment_normarl"] forState:UIControlStateSelected];
    [btn1 setImage:[UIImage imageNamed:@"itunes_comment_selected"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.selected = YES;
    self.btn3 = btn1;
    btn1.tag = 3;
    btn1.frame = CGRectMake(0, 0, ViewHeight, ViewHeight);
    [view1 addSubview:btn1];
    [contentV addSubview:view1];
    //label
    UILabel *label1 = [[UILabel alloc]init];
    NSString *str =  @"给好评传播正能量";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString: str];
    NSRange range = [str rangeOfString:@"好评"];
    [string addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x31bc77) range:range];
    label1.attributedText = string;
    label1.font = [UIFont systemFontOfSize:textSize];
    label1.frame = CGRectMake(CGRectGetMaxX(btn1.frame)+10, textY, 0, 0);
    [label1 setTextColor:UIColorFromRGB(0x575757)];
    [label1 sizeToFit];
    [view1 addSubview:label1];
    
    //4
    UIView *view2= [[UIView alloc]initWithFrame:CGRectMake(labelLeading, CGRectGetMaxY(view1.frame)+lineMagin, contentV.bounds.size.width-labelLeading*2, ViewHeight)];
    //button
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"itunes_comment_normarl"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"itunes_comment_selected"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2 = btn2;
    btn2.tag = 2;
    btn2.frame = CGRectMake(0, 0, ViewHeight, ViewHeight);
    [view2 addSubview:btn2];
    [contentV addSubview:view2];
    //label
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"无视我－拒绝冷漠";
    label2.font = [UIFont systemFontOfSize:textSize];
    label2.textColor = UIColorFromRGB(0x575757);
    label2.frame = CGRectMake(CGRectGetMaxX(btn2.frame)+10, textY, 0, 0);
    [label2 setTextColor:UIColorFromRGB(0x323232)];
    [label2 sizeToFit];
    [view2 addSubview:label2];

    //5
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(labelLeading, CGRectGetMaxY(view2.frame)+lineMagin, contentV.bounds.size.width-labelLeading*2, goodBtnHeight);
    [btn3 setTitle:@"好" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(GoodClick) forControlEvents:UIControlEventTouchUpInside];
    [contentV addSubview:btn3];
    [btn3 setTitleColor:UIColorFromRGB(0x31bc77) forState:UIControlStateNormal];
    btn3.layer.borderWidth = 1;
    btn3.layer.borderColor = [UIColorFromRGB(0x4fd592) CGColor];
    btn3.layer.hidden = NO;
    btn3.layer.cornerRadius = 6;
}


-(void)btnClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    if (btn.tag == 3) {
        self.btn2.selected = !self.btn2.isSelected;
    } else {
        self.btn3.selected = !self.btn3.isSelected;
    }
}

-(void)GoodClick{
    if (self.btn3.isSelected) {
        NSURL *url = [NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=940376535"];
        [[UIApplication sharedApplication] openURL:url];
        //评论过标记
//        NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:nowVersion];
//        [self.view removeFromSuperview];
    }else{
//        [self.view removeFromSuperview];
    }
}

@end
