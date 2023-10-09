//
//  JYSheQuViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYSheQuViewController.h"
#import "JYRegisterViewController.h"

@interface JYSheQuViewController ()
@property(weak,nonatomic) UIImageView *xiaoMao;
@property(weak,nonatomic) UILabel* loginLabel;
@property(weak,nonatomic) UIButton *registerButton;

@end

@implementation JYSheQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBackgoundColor;
    [self initViews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self laySubViews];
}
//立即登录注册
-(void)registerButtonClick{
    NSLog(@"%s",__func__);
    [self presentViewController:[[JYRegisterViewController alloc]init] animated:YES completion:nil];
}
//left navigationItem
-(void)renClick{
    NSLog(@"%s",__func__);
}
-(void)initViews{
    //左边人
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(renClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *view = [[UIView alloc]initWithFrame:btn.bounds];
    [view addSubview:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    //title
    self.navigationItem.title = @"我的关注";
    //小猫
    UIImageView *xiaomao = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_cry_icon"] highlightedImage:nil];
    self.xiaoMao = xiaomao;
    [xiaomao sizeToFit];
    [self.view addSubview:xiaomao];
    
    //labelLogin
    UILabel *loginLabel = [[UILabel alloc]init];
    self.loginLabel = loginLabel;
    loginLabel.text = @"快快登录吧，关注百思最in牛人好友动态，让你过把瘾儿～欧耶～～～～！";
    loginLabel.numberOfLines = 0;
    loginLabel.lineBreakMode = NSLineBreakByWordWrapping;
    loginLabel.font = [UIFont systemFontOfSize:17];
    loginLabel.textColor = [UIColor blackColor];
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [loginLabel sizeToFit];
    [self.view addSubview:loginLabel];
    //注册按钮
    UIButton *registerButton = [[UIButton alloc]init];
    self.registerButton = registerButton;
    [registerButton setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    [registerButton setTitle:@"立即登录注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerButton sizeToFit];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
}
-(void)laySubViews{
    //小猫
    self.xiaoMao.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.xiaoMao attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.xiaoMao attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    //登录注册推荐词
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:250]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.xiaoMao attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    //buttonRegister
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_loginLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.registerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    
}
@end
