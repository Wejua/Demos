//
//  WJTokenModel.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/7.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "access_token" = "2.00rse8OGrxpZ9D4dc8f3e1a3syIEMC";
 "expires_in" = 136227;
 isRealName = true;
 "remind_in" = 136227;
 uid = 5710257713;
 */
@interface WJUserAccountModel : NSObject
@property(copy,nonatomic)NSString *access_token;
@property(nonatomic)NSTimeInterval expires_in;
@property(copy,nonatomic)NSString *uid;
//算出来的过期时间
@property(strong,nonatomic)NSDate *expiresDate;

-(void)saveUserAccount;
+(WJUserAccountModel *)sharedUserAccount;
@end
