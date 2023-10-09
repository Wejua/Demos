//
//  JYRegisterViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/30.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYRegisterViewController.h"

@interface JYRegisterViewController ()
//关闭按钮
@property(weak,nonatomic)UIButton *closeButton;
//注册账号
@property(weak,nonatomic)UIButton *registerAccountButton;
//背景图片
@property(weak,nonatomic)UIImageView *backImage;


//登录backView
@property(weak,nonatomic)UIView *loginView;
@property(weak,nonatomic)UIImageView *fieldBackImae;
//手机号
@property(weak,nonatomic)UITextField *TextFieldPhoneNumber;
//密码
@property(weak,nonatomic)UITextField *passWordTextField;
//登录
@property(weak,nonatomic)UIButton *loginButton;
//忘记密码
@property(weak,nonatomic)UIButton *forgetPassWordButton;


//注册backView
@property(weak,nonatomic)UIView *registerView;
//电话
@property(weak,nonatomic)UITextField *TextFieldPhoneNumber2;
//密码
@property(weak,nonatomic)UITextField *passWordTextField2;
//注册
@property(weak,nonatomic)UIButton *registerButton;


//快速登录
@property(weak,nonatomic)UILabel *quickLoginLabel;
//QQ登录
@property(weak,nonatomic)UIButton *QQImageButton;
@property(weak,nonatomic)UILabel *QQLabel;
//微博登录
@property(weak,nonatomic)UIButton *weiBoImageButton;
@property(weak,nonatomic)UILabel *weiBoLabel;
//腾讯登录
@property(weak,nonatomic)UIButton *tengXunImageButton;
@property(weak,nonatomic)UILabel *tengXunLabel;
//快速登录线
@property(weak,nonatomic)UIImageView *leftQuickLine;
@property(weak,nonatomic)UIImageView *rightQuickLine;
@property(nonatomic,assign) BOOL isLoginButtonInScreen;
@end

@implementation JYRegisterViewController

-(void)laySubViews{
    //快速登录线
    self.leftQuickLine.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightQuickLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[leftQuickLine]-(>=0)-[quickLoginLabel]-(>=0)-[rightQuickLine]-30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"leftQuickLine":self.leftQuickLine,@"quickLoginLabel":self.quickLoginLabel,@"rightQuickLine":self.rightQuickLine}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.quickLoginLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.quickLoginLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.weiBoImageButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
//    hypot([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    NSLog(@"%@",NSStringFromCGSize([UIScreen mainScreen].bounds.size));
    
    //快速登录
    self.quickLoginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.QQImageButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.QQLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.weiBoImageButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.weiBoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tengXunImageButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.tengXunLabel.translatesAutoresizingMaskIntoConstraints = NO;

    //label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[QQLabel]-(>=0)-[weiBoLabel]-(>=0)-[tengXunLabel]-30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"QQLabel":self.QQLabel,@"weiBoLabel":self.weiBoLabel,@"tengXunLabel":self.tengXunLabel}]];
    //imageButton
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[QQImageButton]-(>=0)-[weiBoImageButton]-(>=0)-[tengXunImageButton]-30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"QQImageButton":self.QQImageButton,@"weiBoImageButton":self.weiBoImageButton,@"tengXunImageButton":self.tengXunImageButton}]];
    //V,QQ
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[QQImageButton]-(==10)-[QQLabel]-20-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"QQImageButton":self.QQImageButton,@"QQLabel":self.QQLabel}]];
    //V,weiBo
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[weiBoImageButton]-(==10)-[weiBoLabel]-20-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"weiBoImageButton":self.weiBoImageButton,@"weiBoLabel":self.weiBoLabel}]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.weiBoLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    //V,tengXunButton
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[tengXunImageButton]-(==10)-[tengXunLabel]-20-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"tengXunImageButton":self.tengXunImageButton,@"tengXunLabel":self.tengXunLabel}]];

    //loginView
    self.passWordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.TextFieldPhoneNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.forgetPassWordButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.loginView.translatesAutoresizingMaskIntoConstraints = NO;
   [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[loginView]-90-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"loginView":self.loginView}]];
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[loginView]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"loginView":self.loginView}]];
    //loginViewSubviews
    [self.loginView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TextFieldPhoneNumber(45)]-0-[passWordTextField(==45)]-30-[loginButton(==30)]-30-[forgetPassWordButton]-0-|" options:NSLayoutFormatAlignAllRight metrics:@{} views:@{@"TextFieldPhoneNumber":self.TextFieldPhoneNumber,@"passWordTextField":self.passWordTextField,@"loginButton":self.loginButton,@"forgetPassWordButton":self.forgetPassWordButton}]];
    //TextFieldPhoneNumber
    [self.loginView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TextFieldPhoneNumber]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"TextFieldPhoneNumber":self.TextFieldPhoneNumber}]];
    //passWordTextField
    [self.loginView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[passWordTextField]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"passWordTextField":self.passWordTextField}]];
    //loginButton
    [self.loginView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[loginButton]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"loginButton":self.loginButton}]];
    //registerView
//    self.registerView.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
    self.passWordTextField2.translatesAutoresizingMaskIntoConstraints = NO;
    self.TextFieldPhoneNumber2.translatesAutoresizingMaskIntoConstraints = NO;
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.registerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(90)-[registerView]-(90)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"registerView":self.registerView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(350)-[registerView]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"registerView":self.registerView}]];
    //loginViewSubviews
    [self.registerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[TextFieldPhoneNumber2(45)]-0-[passWordTextField2(==45)]-30-[registerButton(==30)]-0-|" options:NSLayoutFormatAlignAllCenterX metrics:@{} views:@{@"TextFieldPhoneNumber2":self.TextFieldPhoneNumber2,@"passWordTextField2":self.passWordTextField2,@"registerButton":self.registerButton}]];
    //TextFieldPhoneNumber
    [self.registerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[TextFieldPhoneNumber2]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"TextFieldPhoneNumber2":self.TextFieldPhoneNumber2}]];
    //passWordTextField
    [self.registerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[passWordTextField2]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"passWordTextField2":self.passWordTextField2}]];
    //loginButton
    [self.registerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[registerButton]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"registerButton":self.registerButton}]];
    
    
    //背景
    self.backImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backImage]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:@{} views:@{@"backImage":self.backImage}]];
      [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backImage]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:@{} views:@{@"backImage":self.backImage}]];
    
    //closeButton和注册账号
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.registerAccountButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[closeButton(==30)]-(>=0)-[registerAccountButton(==70)]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"closeButton":self.closeButton,@"registerAccountButton":self.registerAccountButton}]];
    //closeButton
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40]];
}
-(void)closeButtonClick{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)forgetPassWordButtonClick{
    NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
-(void)loginButtonClick{
    NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
-(void)registerButtonClick{
    NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}

-(void)registerAccountButtonClick{
    NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
    [UIView animateWithDuration:0.3 animations:^{
        if(self.isLoginButtonInScreen == YES){
            [self.registerAccountButton setTitle:@"已有账号?" forState:UIControlStateNormal];
            self.loginView.transform = CGAffineTransformTranslate(self.loginView.transform, -414, 0);
            self.registerView.transform = CGAffineTransformTranslate(self.registerView.transform, -414, 0);
        }else{
            [self.registerAccountButton setTitle:@"注册账号" forState:UIControlStateNormal];
            self.loginView.transform = CGAffineTransformTranslate(self.loginView.transform, 414, 0);
            self.registerView.transform = CGAffineTransformTranslate(self.registerView.transform, 414, 0);
        }
    }];
    self.isLoginButtonInScreen = !self.isLoginButtonInScreen;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    //初始化登录button位置
    self.isLoginButtonInScreen = YES;
}
-(void)initSubViews{
    //注册界面背景图片
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_register_background"] highlightedImage:nil];
    self.backImage = backImage;
    [self.view addSubview:backImage];
    
    //注册账号
    UIButton *registerAccountButton = [[UIButton alloc]init];
    self.registerAccountButton = registerAccountButton;
    [registerAccountButton setTitle:@"注册账号" forState:UIControlStateNormal];
    registerAccountButton.titleLabel.font = [UIFont systemFontOfSize:15];
    registerAccountButton.titleLabel.textColor = [UIColor whiteColor];
    registerAccountButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [registerAccountButton sizeToFit];
    [registerAccountButton addTarget:self action:@selector(registerAccountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerAccountButton];
    
    //左上关闭按钮
    UIButton *closeButton = [[UIButton alloc]init];
    self.closeButton = closeButton;
    [closeButton setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    [closeButton sizeToFit];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    //组合view
    UIView *loginView = [[UIView alloc]init];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    //手机号textfield
    UITextField *TextFieldPhoneNumber = [[UITextField alloc]init];
    self.TextFieldPhoneNumber = TextFieldPhoneNumber;
    TextFieldPhoneNumber.placeholder = @"请输入手机号";
    TextFieldPhoneNumber.font = [UIFont systemFontOfSize:14];
    TextFieldPhoneNumber.textColor = [UIColor blackColor];
    TextFieldPhoneNumber.background = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    [loginView addSubview:TextFieldPhoneNumber];
    //passWordTextField
    UITextField *passWordTextField = [[UITextField alloc]init];
    self.passWordTextField = passWordTextField;
    passWordTextField.placeholder = @"请输入密码";
    passWordTextField.font = [UIFont systemFontOfSize:14];
    passWordTextField.textColor = [UIColor blackColor];
    passWordTextField.background = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    [loginView addSubview:passWordTextField];
    //登录按钮
    UIButton *loginButton = [[UIButton alloc]init];
    self.loginButton = loginButton;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    loginButton.titleLabel.textColor = [UIColor whiteColor];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"loginBtnBg"] forState:UIControlStateNormal];
    [loginButton sizeToFit];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginButton];
    //忘记密码
    UIButton *forgetPassWordButton = [[UIButton alloc]init];
    self.forgetPassWordButton = forgetPassWordButton;
    [forgetPassWordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPassWordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    forgetPassWordButton.titleLabel.textColor = [UIColor whiteColor];
    [forgetPassWordButton sizeToFit];
    [forgetPassWordButton addTarget:self action:@selector(forgetPassWordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPassWordButton];
    
    
    
    
    //组合view2
    UIView *registerView = [[UIView alloc]init];
    self.registerView = registerView;
    [self.view addSubview:registerView];
    //手机号textfield
    UITextField *TextFieldPhoneNumber2 = [[UITextField alloc]init];
    TextFieldPhoneNumber2.placeholder = @"请输入手机号";
    TextFieldPhoneNumber2.font = [UIFont systemFontOfSize:14];
    TextFieldPhoneNumber2.background = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    self.TextFieldPhoneNumber2 = TextFieldPhoneNumber2;
    [registerView addSubview:TextFieldPhoneNumber2];
    //passWordTextField
    UITextField *passWordTextField2 = [[UITextField alloc]init];
    passWordTextField2.placeholder = @"请输入密码";
    passWordTextField2.font = [UIFont systemFontOfSize:14];
    passWordTextField2.background = [UIImage imageNamed:@"login_rgister_textfield_bg"];
    self.passWordTextField2 = passWordTextField2;
    [registerView addSubview:passWordTextField2];
    //注册按钮
    UIButton *registerButton = [[UIButton alloc]init];
    self.registerButton = registerButton;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    registerButton.titleLabel.textColor = [UIColor whiteColor];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"loginBtnBg"] forState:UIControlStateNormal];
    [registerButton sizeToFit];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [registerView  addSubview:registerButton];
    registerButton.imageView.contentMode = UIViewContentModeRedraw;
    
    //快速登录
    //leftQuickLine
    UIImageView *leftQuickLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_register_left_line"] highlightedImage:nil];
    self.leftQuickLine = leftQuickLine;
    [leftQuickLine sizeToFit];
    [self.view addSubview:leftQuickLine];
    //rightQuickLine
    UIImageView *rightQuickLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_register_right_line"] highlightedImage:nil];
    self.rightQuickLine = rightQuickLine;
    [rightQuickLine sizeToFit];
    [self.view addSubview:rightQuickLine];
    //label
    UILabel *quickLoginLabel = [[UILabel alloc]init];
    self.quickLoginLabel = quickLoginLabel;
    quickLoginLabel.text = @"快速登录";
    quickLoginLabel.textColor = [UIColor whiteColor];
    quickLoginLabel.font = [UIFont systemFontOfSize:18];
    quickLoginLabel.textAlignment = NSTextAlignmentCenter;
    [quickLoginLabel sizeToFit];
    [self.view addSubview:quickLoginLabel];
    //QQ登录
    UIButton *QQImageButton = [[UIButton alloc]init];
    [QQImageButton setImage:[UIImage imageNamed:@"login_QQ_icon"] forState:UIControlStateNormal];
    self.QQImageButton = QQImageButton;
    [QQImageButton sizeToFit];
    [self.view addSubview:QQImageButton];
    //label
    UILabel *QQLabel = [[UILabel alloc]init];
    self.QQLabel = QQLabel;
    QQLabel.text = @"QQ登录";
    QQLabel.textColor = [UIColor whiteColor];
    QQLabel.font = [UIFont systemFontOfSize:18];
    QQLabel.textAlignment = NSTextAlignmentCenter;
    [QQLabel sizeToFit];
    [self.view addSubview:QQLabel];
    //微博登录
    UIButton *weiBoImageButton = [[UIButton alloc]init];
    [weiBoImageButton setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
    self.weiBoImageButton = weiBoImageButton;
    [weiBoImageButton sizeToFit];
    [self.view addSubview:weiBoImageButton];
    //label
    UILabel *weiBoLabel = [[UILabel alloc]init];
    self.weiBoLabel = weiBoLabel;
    weiBoLabel.text = @"微博登录";
    weiBoLabel.textColor = [UIColor whiteColor];
    weiBoLabel.font = [UIFont systemFontOfSize:18];
    weiBoLabel.textAlignment = NSTextAlignmentCenter;
    [weiBoLabel sizeToFit];
    [self.view addSubview:weiBoLabel];
    //腾讯登录
    UIButton *tengXunImageButton = [[UIButton alloc]init];
    [tengXunImageButton setImage:[UIImage imageNamed:@"login_tecent_icon"] forState:UIControlStateNormal];
    self.tengXunImageButton = tengXunImageButton;
    [tengXunImageButton sizeToFit];
    [self.view addSubview:tengXunImageButton];
    //label
    UILabel *tengXunLabel = [[UILabel alloc]init];
    self.tengXunLabel = tengXunLabel;
    tengXunLabel.text = @"腾讯登录";
    _tengXunLabel.textColor = [UIColor whiteColor];
    tengXunLabel.font = [UIFont systemFontOfSize:18];
    tengXunLabel.textAlignment = NSTextAlignmentCenter;
    [tengXunLabel sizeToFit];
    [self.view addSubview:tengXunLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self laySubViews];
    //没有布局注册在外面，在这里移过去
    self.registerView.transform = CGAffineTransformTranslate(self.registerView.transform, 414, -200);
}

@end
