//
//  WJUserInfoModel.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJUserInfoModel.h"
#import "WJUserAccountModel.h"
#import "SDWebImageManager.h"
@interface WJUserInfoModel()
//@property(copy,nonatomic)NSArray *statuses;
@end
@implementation WJUserInfoModel
-(void)loadData{
}
//cell高度
-(CGFloat)cellHight{
    NSInteger picCount = _pic_urls.count;
//    CGFloat oneImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets)/2;
    CGFloat NineImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets-space*2)/3;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dic1 = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGRect rect = [_text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-2*insets, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic1 context:nil];
    CGFloat MaxYForMiddleTitleLabel = insets + 40 + insets + rect.size.height;
    //retweeted微博高度
    NSDictionary *dic2 = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect2 = [_retweeted_status.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-2*insets, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic2 context:nil];
    CGFloat zanImgHeight = 11.6;
    if(_pic_urls.count){
        //collectinoView高度
        CGFloat collectionViewHeight;
        if(picCount == 1){
            //获取小图片大小，定义一张图片时的高度
            CGSize size = [[[SDWebImageManager sharedManager]imageCache]imageFromCacheForKey:_pic_urls[0]].size;
            size.width = size.width < 40 ? 40 : size.width;
            size.width = size.width > 200 ? 200 :size.width;
            _oneImgeSize = CGSizeMake(size.width*2.2, size.height*2.2);
            collectionViewHeight = insets +  _oneImgeSize.height;
        }else if(picCount > 1 && picCount <= 3){
            collectionViewHeight = NineImgWidth+insets;
        }else if(picCount >3 && picCount <= 6){
            collectionViewHeight = NineImgWidth*2+space+insets;
        }else{
            collectionViewHeight = [UIScreen mainScreen].bounds.size.width-2*insets+insets;
        }
        return MaxYForMiddleTitleLabel + collectionViewHeight + insets + insets + zanImgHeight + insets+0.5;
    }else{
        //retweeted里的collectinoView高度,有collectionView图片就不会有retweeted微博
        CGFloat retweetedLabelHeight;
        if(_retweeted_status.text){
            retweetedLabelHeight = rect2.size.height+insets;
        }else{
            retweetedLabelHeight = rect2.size.height;
        }
        CGFloat collectionViewHeight2;
        NSInteger picCount2 = _retweeted_status.pic_urls.count;
        if( picCount2== 0){
            collectionViewHeight2 = 0;
        }else if(picCount2 == 1){
            //获取小图片大小，定义一张图片时的高度
            CGSize size = [[[SDWebImageManager sharedManager]imageCache]imageFromCacheForKey:_retweeted_status.pic_urls[0]].size;
            size.width = size.width < 40 ? 40 : size.width;
            size.width = size.width > 200 ? 200 :size.width;
            _oneImgeSize = CGSizeMake(size.width*2.2, size.height*2.2);
            collectionViewHeight2 = _oneImgeSize.height + insets;
        }else if(picCount2 > 1 && picCount2 <= 3){
            collectionViewHeight2 = NineImgWidth+ insets;
        }else if(picCount2 >3 && picCount2 <= 6){
            collectionViewHeight2 = NineImgWidth*2+space+ insets;
        }else{
            collectionViewHeight2 = [UIScreen mainScreen].bounds.size.width-2*insets+ insets;
        }
        int retweetedViewHeight = 0;
        if(_retweeted_status.text || picCount2){
            retweetedViewHeight = insets;
        }
//        NSLog(@"MaxYForMiddleTitleLabel:%f,retweetedViewHeight:%d,retweetedLabelHeight:%f,collectionViewHeight2:%f",MaxYForMiddleTitleLabel,retweetedViewHeight,retweetedLabelHeight,collectionViewHeight2);
        return MaxYForMiddleTitleLabel + retweetedViewHeight + retweetedLabelHeight + collectionViewHeight2  + insets + insets + zanImgHeight + insets+0.5;
    }
}
-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    _model_id = [keyedValues[@"id"] intValue];
    //touXiangImg
    self.profile_image_url =  keyedValues[@"user"][@"profile_image_url"];
    //name
    self.name = keyedValues[@"user"][@"name"];
    //source
    NSString *source = keyedValues[@"source"];
    if(![source isEqualToString:@""]){
        NSString *newS = [source substringFromIndex:[source rangeOfString:@">"].location+1];
        self.source = [newS substringToIndex:[newS rangeOfString:@"<"].location];
    }
    //text
    self.text = keyedValues[@"text"];
    //pictures
    NSArray *array = keyedValues[@"pic_urls"];
    NSMutableArray *pic_urls = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [pic_urls addObject:dic[@"thumbnail_pic"]];
    }
    self.pic_urls = pic_urls;
    //pic_urls没有图片下面三张就没有
    self.thumbnail_pic = keyedValues[@"bmiddle_pic"];
    self.bmiddle_pic = keyedValues[@"bmiddle_pic"];
    self.original_pic = keyedValues[@"original_pic"];
    //created_at
    self.created_at = keyedValues[@"created_at"];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [formater dateFromString:keyedValues[@"created_at"]];
    NSTimeInterval timeInterval = [[NSDate date]timeIntervalSinceDate:date];
    if(timeInterval/60 < 1){
        self.created_at = @"刚刚";
    }else if(timeInterval/3600 < 1){
        self.created_at = [NSString stringWithFormat:@"%d分钟前",(int)timeInterval/60];
    }else if(timeInterval/(3600*24) < 1){
        self.created_at = [NSString stringWithFormat:@"%d小时前",(int)timeInterval/(3600)];
    }else{
        self.created_at = [NSString stringWithFormat:@"%d天前",(int)timeInterval/(3600*24)];
    }
    self.reposts_count = [[NSString alloc]initWithFormat:@"%@",keyedValues[@"reposts_count"]];
    self.comments_count = [[NSString alloc]initWithFormat:@"%@",keyedValues[@"comments_count"]];
    self.attitudes_count = [[NSString alloc]initWithFormat:@"%@",keyedValues[@"attitudes_count"]];
    //转发微博
    if([[keyedValues allKeys]containsObject:@"retweeted_status"]){
        WJUserInfoModel *tweetedModel = [[WJUserInfoModel alloc]init];
        [tweetedModel setValuesForKeysWithDictionary:keyedValues[@"retweeted_status"]];
        self.retweeted_status = tweetedModel;
    }
    //text中网址
//    NSInteger length = ;
    NSRegularExpression *regularE = [[NSRegularExpression alloc]initWithPattern:@"http://[a-zA-Z\\d./]+" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSArray *count = [regularE matchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0,self.text.length)];
    for (int i =0; i<count.count; i++) {
        NSTextCheckingResult *result = [regularE firstMatchInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0,self.text.length)];
        _textWebSite = [self.text substringWithRange:result.range];
        self.text = [self.text stringByReplacingOccurrencesOfString:_textWebSite withString:@"网页链接"];
        self.attriButedText = [[NSMutableAttributedString alloc]initWithString:self.text];
        NSRange range = [self.text rangeOfString:@"网页链接"];
        [self.attriButedText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:70/255.0 green:110/255.0 blue:160/255.0 alpha:1.0] range:range];
//        NSLog(@"_textWebSite:\n%@",_textWebSite);
    }
}
@end
