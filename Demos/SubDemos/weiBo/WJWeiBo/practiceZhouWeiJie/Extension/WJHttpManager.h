//
//  WJHttpManager.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/9.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    WJHttpManagerReturnTypeJson = 0,
    WJHttpManagerReturnTypeImage,
    WJHttpManagerReturnTypeVideo,
    WJHttpManagerReturnTypeXML
}WJHttpManagerReturnType;
@interface WJHttpManager : NSObject
//+(void)getWithURL:(NSURL*)url completionHandler:(void(^)(NSDictionary *dic,NSError *error))completion;
//+(void)postWithURL:(NSURL*)url parameters:(NSDictionary*)parameters;
@end
