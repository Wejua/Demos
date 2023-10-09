//
//  WJUserInfoModel.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//
#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>

@interface WJUserInfoModel : NSObject
@property(copy,nonatomic) NSString *textWebSite;
//id
@property(nonatomic)NSInteger model_id;
/*@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@"
 */
//Fri Feb 09 21:38:37 +0800 2018
@property(copy,nonatomic)NSString *created_at;
// <a href=\"http://app.weibo.com/t/feed/6e3owN\" rel=\"nofollow\">iPhone 7 Plus</a>
//设备名在这个字符串里面
@property(copy,nonatomic)NSString *source;
//对应touXiangImgV的URLstring
@property(copy,nonatomic)NSString *profile_image_url;
//nameLabel
@property(copy,nonatomic)NSString *name;
//对应middleTitleLabel
@property(copy,nonatomic)NSString *text;
@property(strong,nonatomic)NSMutableAttributedString *attriButedText;
//如果发布的是图片，就在这个数组
@property(copy,nonatomic)NSArray *pic_urls;
//转发次数
@property(copy,nonatomic)NSString *reposts_count;
//评论次数
@property(copy,nonatomic)NSString *comments_count;
//赞次数
@property(copy,nonatomic)NSString *attitudes_count;
//极小图片,以下三张图片，如果pictures(pic_url)为空，就不会有
@property(copy,nonatomic)NSString *thumbnail_pic;
//中等图片
@property(copy,nonatomic)NSString *bmiddle_pic;
//原生图片，大图片
@property(copy,nonatomic)NSString *original_pic;
//转发信息，如果没有转发信息，就没有这个key
@property(strong,nonatomic)WJUserInfoModel *retweeted_status;
//计算cell高度
@property(nonatomic)CGFloat cellHight;
@property(nonatomic)CGSize oneImgeSize;
//+(void)loadData;
@end
