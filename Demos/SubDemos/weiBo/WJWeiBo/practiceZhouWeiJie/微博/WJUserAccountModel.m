//
//  WJTokenModel.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/7.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJUserAccountModel.h"
@implementation WJUserAccountModel
//单例
static WJUserAccountModel *instance;
+(instancetype)sharedUserAccount{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WJUserAccountModel loadUserAccount];
    });
    return instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(void)setExpires_in:(NSTimeInterval)expires_in{
    _expires_in = expires_in;
    _expiresDate = [NSDate dateWithTimeIntervalSinceNow:expires_in];
}
-(NSString *)description{
    NSArray *keys = @[@"access_token",@"expires_in",@"uid",@"expiresDate"];
    NSDictionary *dic = [NSDictionary dictionaryWithValuesForKeys:keys];
    return dic.description;
}
//归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_access_token forKey:@"access_token"];
    [coder encodeObject:_expiresDate forKey:@"expiresDate"];
    [coder encodeObject:_uid forKey:@"uid"];
}
-(void)saveUserAccount{
    NSString *accountPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"];
    [NSKeyedArchiver archiveRootObject:self toFile:accountPath];
}
//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    _access_token = [aDecoder decodeObjectForKey:@"access_token"];
    _expiresDate = [aDecoder decodeObjectForKey:@"expiresDate"];
    _uid = [aDecoder decodeObjectForKey:@"uid"];
    return self;
}
+(instancetype)loadUserAccount{
    NSString *accountPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"];
    WJUserAccountModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    NSDate *date = [NSDate date];
    if([date compare:model.expiresDate] == NSOrderedAscending){
        return model;
    }
    return [[WJUserAccountModel alloc]init];
}
@end
