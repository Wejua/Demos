//
//  TaboolaTestViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/28.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "TaboolaTestViewController.h"
#import <WebKit/WebKit.h>
#import <TaboolaSDK/TaboolaJS.h>

@interface TaboolaTestViewController ()<WKNavigationDelegate,TaboolaJSDelegate>
@end

@implementation TaboolaTestViewController
{
    WKWebView *webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];

    
    [self taboolaTest];
}

-(void)viewWillDisappear:(BOOL)animated{
    [WJActivityView dismiss];
}
-(void)taboolaTest{
    webview = [[WKWebView alloc] init];
    [self.view addSubview:webview];

    webview.navigationDelegate = self;
    
    webview.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray* horizConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[webview]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"webview": webview}];
    NSArray* vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[webview]-0-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"webview": webview}] ;
    [self.view addConstraints:horizConstraints];
    [self.view addConstraints:vertConstraints];
    
    [TaboolaJS sharedInstance].delegate = self;
    [[TaboolaJS sharedInstance] setLogLevel:LogLevelWarning];
    [[TaboolaJS sharedInstance] registerWebView:webview];
    
    [self loadExamplePage];
}
- (void)loadExamplePage {
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"sampleFeedContentPage" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:appHtml baseURL: [NSURL URLWithString:@"https:"]];
    [WJActivityView show];
    
}
#pragma mark - delegate
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic{
    return NO;
}
- (void)webView:(UIView*) webView didLoadPlacementNamed:(NSString *) placementName withHeight:(CGFloat)height{
    [WJActivityView dismiss];
}
@end
