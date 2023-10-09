//
//  WJWeiBoLoginViewController.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/6.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWeiBoLoginViewController.h"
#import "WJUserAccountModel.h"
#import "SVProgressHUD.h"

@interface WJWeiBoLoginViewController ()<UIWebViewDelegate>

@end

@implementation WJWeiBoLoginViewController
#define client_id 3922102441
#define client_secret 0acd2fe4b4c9ed81c7220c541a559160
-(void)loadView{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    self.view = webView;
    //加载oauth授权界面
                        /*
                         必选    类型及范围    说明
                         client_id    true    string    申请应用时分配的AppKey。
                         redirect_uri    true    string    授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
                         */
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"https://api.weibo.com/oauth2/authorize?client_id= 3170677139&redirect_uri=http://www.baidu.com" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];

    //设置返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
}
-(void)dismissVC{
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [SVProgressHUD show];
    NSString *query = request.URL.absoluteURL.query;
    if([query hasPrefix:@"code="]){
        NSString *code = [query substringFromIndex:@"code=".length];
        //利用code获取token
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]] ;
        request.HTTPMethod = @"post";
        /*
         必选    类型及范围    说明
         client_id    true    string    申请应用时分配的AppKey。
         client_secret    true    string    申请应用时分配的AppSecret。
         grant_type    true    string    请求的类型，填写authorization_code
         */
        NSString *httpBody = [[NSString alloc]initWithFormat:@"client_id=3170677139&client_secret=8dc62d2a6d5a7a3f49436015bb233045&grant_type=authorization_code&code=%@&redirect_uri=http://www.baidu.com",code];
        request.HTTPBody = [ httpBody dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //解析json然后转模型
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //转模型
            WJUserAccountModel *model = [[WJUserAccountModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            //归档
            [model saveUserAccount];
            if(error){
                NSLog(@"%@",error);
            }
        }];
        [dataTask resume];
        [self dismissViewControllerAnimated:YES completion:^{
            //切换根控制器，换成已登录状
            [[NSNotificationCenter defaultCenter]postNotificationName:@"switchKeyWindowRootViewController" object:nil userInfo:nil];
        }];
        return NO;
    }
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

@end
