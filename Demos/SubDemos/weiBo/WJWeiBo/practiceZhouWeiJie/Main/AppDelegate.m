//
//  AppDelegate.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/24.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "AppDelegate.h"
#import "JYFaBuViewController.h"
#import "WJTabBarController.h"
#import "WJUserAccountModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(switchKeyWindowRootViewController) name:@"switchKeyWindowRootViewController" object:nil];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self switchKeyWindowRootViewController];
    return YES;
}
-(void)switchKeyWindowRootViewController{    //判断用户是否登录
    _window.rootViewController = [[WJTabBarController alloc]init];
    [_window makeKeyAndVisible];
    //判断是否登录或者token是否过期
    if(![WJUserAccountModel sharedUserAccount].access_token){
        
    }
    //判断版本需不需要更新，更新就换新特性界面
    double bundleVersion =  [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] doubleValue];
    double preVersion = [[[NSUserDefaults standardUserDefaults]objectForKey:@"preVersion"] doubleValue];
    if(bundleVersion > preVersion){
            //要更新app,根控制器设置成新特性界面
    }
    //保存版本号
    [[NSUserDefaults standardUserDefaults]setDouble:bundleVersion forKey:@"preVersion"];
//    NSLog(@"%s,access_token:%@，expireDate:%@",__func__,[WJUserAccountModel sharedUserAccount].access_token,[WJUserAccountModel sharedUserAccount].expiresDate);
}
-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"switchKeyWindowRootViewController" object:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
