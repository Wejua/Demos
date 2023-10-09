//
//  JYTabBarControllerViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJTabBarController.h"

#import "JYWoViewController.h"
#import "JYSheQuViewController.h"
#import "JYZuiXinViewController.h"
#import "WJWeiBoViewController.h"
#import "JYNavigationViewController.h"
#import "JYFaBuViewController.h"
#import "WJFaBuViewController.h"
#import "WJFaXianViewController.h"
#import "WJTransitionAnimator.h"


#pragma mark - JYTabBar

#pragma mark - JYTabBarControllerViewController
@interface WJTabBarController ()
@property(weak,nonatomic)UIButton *faBuButton;
@property(strong,nonatomic)WJTransitionAnimator *animator;
@end

@implementation WJTabBarController

-(void)faBuClick2{
    //展示加号弹出界面
//    [self.selectedViewController presentViewController:[[JYFaBuViewController alloc]init] animated:NO completion:nil];
    WJFaBuViewController *vc = [[WJFaBuViewController alloc]init];
//    vc.transitioningDelegate = _animator;
//    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.selectedViewController presentViewController:vc animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _animator = [[WJTransitionAnimator alloc]init];
    //加载控制器
    [self addViewControllers];
    //设置文字大小
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    dic2[NSForegroundColorAttributeName] = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTitleTextAttributes:dic2 forState:UIControlStateNormal];
    // 设置tabbar渲染颜色（会改变图片和文字的颜色）
    self.tabBar.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    //文字的偏移(图片不能偏移，会crash）
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    //设置tabbar不透明
    self.tabBar.translucent = NO;
    //tabbar背景色
    self.tabBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
}
-(void)addViewControllers{
    //微博
    JYNavigationViewController *jingHua = [[JYNavigationViewController alloc]initWithRootViewController:[[WJWeiBoViewController alloc]init]];
    jingHua.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"微博" image:[UIImage imageNamed:@"weiBo"]  selectedImage:[UIImage imageNamed:@"weiBoSelected"]];
    //消息
    JYNavigationViewController *zuiXin = [[JYNavigationViewController alloc ]initWithRootViewController:[[JYZuiXinViewController alloc]init]];
    zuiXin.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"xiaoXi"] selectedImage:[UIImage imageNamed:@"xiaoXiSelected"]];
    //发布
    UIViewController *faBu =[[UIViewController alloc]init];
    //设置item无效
    faBu.tabBarItem.enabled = NO;
    //添加自定义button，还没有布局，所以不会显示
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"jiaHao"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"jiaHao"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(faBuClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:btn];
    _faBuButton = btn;
    
    //发现
    JYNavigationViewController *sheQu = [[JYNavigationViewController alloc]initWithRootViewController:[[WJFaXianViewController alloc]init]];
    sheQu.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"faXian"] selectedImage:[UIImage imageNamed:@"faXianSelected"]];
    //我
    JYNavigationViewController *wo = [[JYNavigationViewController alloc]initWithRootViewController:[[JYWoViewController alloc]init]];
    wo.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"wo"] selectedImage:[UIImage imageNamed:@"woSelected"]];
    self.viewControllers = @[jingHua,zuiXin,faBu,sheQu,wo];
}
-(void)viewDidLayoutSubviews{
    //布局自定义button
    float itemW = self.tabBar.bounds.size.width/5;
    float itemH = self.tabBar.bounds.size.height;
    [self.tabBar addSubview:_faBuButton];
    _faBuButton.frame = CGRectMake(2*itemW, 0, itemW, itemH);
}

@end
