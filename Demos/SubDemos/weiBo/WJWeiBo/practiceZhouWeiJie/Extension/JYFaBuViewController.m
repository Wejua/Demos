//
//  JYFaBuViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYFaBuViewController.h"

@interface JYFaBuViewController ()
//动画单元（发视频，发段子。。。）
@property(weak,nonatomic) UIView *view1;
@property(weak,nonatomic) UIView *view2;
@property(weak,nonatomic) UIView *view3;
@property(weak,nonatomic) UIView *view4;
@property(weak,nonatomic) UIView *view5;
@property(weak,nonatomic) UIView *view6;
//动画单元的集合
@property(copy,nonatomic) NSArray *clickedViews;
@end

@implementation JYFaBuViewController
-(void)initViews{
    
    //被view为透明，就不会挡住
    self.view.backgroundColor = [UIColor clearColor];
    //添加蒙版
    UIBlurEffect *vlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:vlurEffect];
    [self.view addSubview:effectView];
    effectView.frame = self.view.bounds;
    
    //添加slogan（标语）
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [slogan sizeToFit];
    [self.view addSubview:slogan];
    slogan.frame = CGRectMake(self.view.bounds.size.width/2-slogan.bounds.size.width/2, 150, slogan.bounds.size.width, slogan.bounds.size.height);
    
    //发视频
    UIView *view1 = [[UIView alloc]init];
    self.view1 = view1;
    [self.view addSubview:view1];
    UIButton *button1 = [[UIButton alloc]init];
    [button1 setImage:[UIImage imageNamed:@"publish-video"] forState:UIControlStateNormal];
    [button1 sizeToFit];
    [button1 addTarget:self action:@selector(fashipin) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button1];
    //发视频title
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"发视频";
    label1.font = [UIFont systemFontOfSize:17];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 sizeToFit];
    [view1 addSubview:label1];
    //约束
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    //发图片
    UIView *view2 = [[UIView alloc]init];
    self.view2 = view2;
    [self.view addSubview:view2];
    UIButton *button2 = [[UIButton alloc]init];
    [button2 setImage:[UIImage imageNamed:@"publish-picture"] forState:UIControlStateNormal];
    [button2 sizeToFit];
    [button2 addTarget:self action:@selector(fatupian) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:button2];
    //label
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"发图片";
    label2.font = [UIFont systemFontOfSize:17];
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 sizeToFit];
    [view2 addSubview:label2];
    
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [view2 addConstraint:[NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view2 addConstraint:[NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view2 addConstraint:[NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view2 addConstraint:[NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    
    [view2 addConstraint:[NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    //发段子
    UIView *view3 = [[UIView alloc]init];
    self.view3 = view3;
    [self.view addSubview:view3];
    //button
    UIButton *button3 = [[UIButton alloc]init];
    [button3 setImage:[UIImage imageNamed:@"publish-text"] forState:UIControlStateNormal];
    [button3 sizeToFit];
    [button3 addTarget:self action:@selector(faduanzi) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:button3];
    //label
    UILabel *label3 = [[UILabel alloc]init];
    label3.text = @"发段子";
    label3.font = [UIFont systemFontOfSize:17];
    label3.textColor = [UIColor blackColor];
    label3.textAlignment = NSTextAlignmentCenter;
    [label3 sizeToFit];
    [view3 addSubview:label3];
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    button3.translatesAutoresizingMaskIntoConstraints = NO;
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view3 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view3 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view3 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label3 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:label3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button3 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [view3 addConstraint:[NSLayoutConstraint constraintWithItem:label3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view3 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    //发声音
    UIView *view4 = [[UIView alloc]init];
    self.view4 = view4;
    [self.view addSubview:view4];
    
    UIButton *button4 = [[UIButton alloc]init];
    [button4 setImage:[UIImage imageNamed:@"publish-audio"] forState:UIControlStateNormal];
    [button4 sizeToFit];
    [button4 addTarget:self action:@selector(fashengyin) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:button4];
    //title
    UILabel *label4 = [[UILabel alloc]init];
    label4.text = @"发声音";
    label4.font = [UIFont systemFontOfSize:17];
    label4.textColor = [UIColor blackColor];
    label4.textAlignment = NSTextAlignmentCenter;
    [label4 sizeToFit];
    [view4 addSubview:label4];
    //约束
    button4.translatesAutoresizingMaskIntoConstraints = NO;
    label4.translatesAutoresizingMaskIntoConstraints = NO;
    view4.translatesAutoresizingMaskIntoConstraints = NO;
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view4 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view4 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view4 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label4 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label4 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [view4 addConstraint:[NSLayoutConstraint constraintWithItem:view4 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label4 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    //发链接
    UIView *view5 = [[UIView alloc]init];
    self.view5 = view5;
    [self.view addSubview:view5];
    UIButton *button5 = [[UIButton alloc]init];
    [button5 setImage:[UIImage imageNamed:@"publish-review"] forState:UIControlStateNormal];
    [button5 sizeToFit];
    [button5 addTarget:self action:@selector(falianjie) forControlEvents:UIControlEventTouchUpInside];
    [view5 addSubview:button5];
    //label
    UILabel *label5 = [[UILabel alloc]init];
    label5.text = @"发链接";
    label5.font = [UIFont systemFontOfSize:17];
    label5.textColor = [UIColor blackColor];
    label5.textAlignment = NSTextAlignmentCenter;
    [label5 sizeToFit];
    [view5 addSubview:label5];
    
    label5.translatesAutoresizingMaskIntoConstraints = NO;
    button5.translatesAutoresizingMaskIntoConstraints = NO;
    view5.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view5 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view4 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view5 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view4 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view5 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [view5 addConstraint:[NSLayoutConstraint constraintWithItem:button5 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view5 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view5 addConstraint:[NSLayoutConstraint constraintWithItem:button5 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view5 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view5 addConstraint:[NSLayoutConstraint constraintWithItem:button5 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view5 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view5 addConstraint:[NSLayoutConstraint constraintWithItem:button5 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label5 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    
    [view5 addConstraint:[NSLayoutConstraint constraintWithItem:button5 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label5 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    //音乐相册
    UIView *view6 = [[UIView alloc]init];
    self.view6 = view6;
    [self.view addSubview:view6];
    //button
    UIButton *button6 = [[UIButton alloc]init];
    [button6 setImage:[UIImage imageNamed:@"publish-offline"] forState:UIControlStateNormal];
    [button6 sizeToFit];
    [button6 addTarget:self action:@selector(yinyuexiangce) forControlEvents:UIControlEventTouchUpInside];
    [view6 addSubview:button6];
    //label
    UILabel *label6 = [[UILabel alloc]init];
    label6.text = @"音乐相册";
    label6.font = [UIFont systemFontOfSize:17];
    label6.textColor = [UIColor blackColor];
    label6.textAlignment = NSTextAlignmentCenter;
    [label6 sizeToFit];
    [view6 addSubview:label6];
    view6.translatesAutoresizingMaskIntoConstraints = NO;
    label6.translatesAutoresizingMaskIntoConstraints = NO;
    button6.translatesAutoresizingMaskIntoConstraints = NO;
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:button6 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view6 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:button6 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view6 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:button6 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view6 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:button6 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label6 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:label6 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button6 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [view6 addConstraint:[NSLayoutConstraint constraintWithItem:label6 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view6 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view6 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view6 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view5 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    //添加取消按钮
    UIButton *quxiao = [[UIButton alloc]init];
    [quxiao setImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [quxiao setImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    [quxiao sizeToFit];
    [self.view addSubview:quxiao];
    float width = quxiao.bounds.size.width;
    float height = quxiao.bounds.size.height;
    quxiao.frame = CGRectMake(self.view.bounds.size.width/2-width/2, self.view.bounds.size.height -10-height, width,height);
    [quxiao addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化并布局好动画单元
    [self initViews];
    self.clickedViews = @[self.view1,self.view2,self.view3,self.view4,self.view5,self.view6];
}
-(void)fashipin{
    
    NSLog(@"%s",__func__);
}
-(void)fatupian{
    
    NSLog(@"%s",__func__);
}
-(void)faduanzi{
    NSLog(@"%s",__func__);
    
}
-(void)fashengyin{
    NSLog(@"%s",__func__);
    
}
-(void)falianjie{
    NSLog(@"%s",__func__);
    
}
-(void)yinyuexiangce{
    NSLog(@"%s",__func__);
    
}
-(void)quxiao{
    NSLog(@"%s",__func__);
    for (int i = 0 ;i<self.clickedViews.count ; i++) {
        [UIView animateWithDuration:0.4 delay:0.04*i usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            //位移
            UIView *view = (UIView *)_clickedViews[i];
            view.transform = CGAffineTransformMakeTranslation(0, 400);
        } completion:^(BOOL finished) {
            if(i == 0){
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (int i = 0 ;i<self.clickedViews.count ; i++) {
        [UIView animateWithDuration:0.4 delay:0.04*i usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            //位移
            UIView *view = (UIView *)_clickedViews[i];
            view.transform = CGAffineTransformMakeTranslation(0, -400);
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
