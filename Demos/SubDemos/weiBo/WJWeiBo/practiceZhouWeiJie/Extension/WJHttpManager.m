//
//  WJHttpManager.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/9.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJHttpManager.h"

@implementation WJHttpManager
+(void)getWithURL:(NSURL*)url completionHandler:(void(^)(NSData * _Nullable data))completion{
    [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                completion(data);
            if(error){
                NSLog(@"%@",error);
            }
        }];
        [dataTask resume];
    }];
}
+(void)postWithURL:(NSURL*)url parameters:(NSDictionary*)parameters{
    
}
@end
