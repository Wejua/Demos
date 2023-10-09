//
//  Post.h
//  textureDemo
//
//  Created by jieyi lu on 2018/4/8.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *post;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *media;
@property (nonatomic, assign) NSInteger via;

@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger comments;
@end
