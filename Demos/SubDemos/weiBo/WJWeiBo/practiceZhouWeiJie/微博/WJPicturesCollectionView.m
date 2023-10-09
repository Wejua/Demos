//
//  WJPicturesCollectionView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/10.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJPicturesCollectionView.h"
#import "SDImageCache.h"

@implementation WJPicturesCollectionView
//计算相对窗口位置
-(CGRect)fromRect:(NSIndexPath *)indexPath{
    CGRect frame = [self cellForItemAtIndexPath:indexPath].frame;
    CGRect rect =[self convertRect:frame toView:[UIApplication sharedApplication].keyWindow];
    return rect;
}
//计算在photobroser中位置
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath{
    //获取图片
    NSString *url = _model.pic_urls[indexPath.row];
    NSString *key = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:key];
    CGFloat scale = image.size.height/image.size.width;
    CGFloat height = scale * SCREENSIZE.width;
    CGFloat width = SCREENSIZE.width;
    CGFloat Y = (SCREENSIZE.height - height) *0.5;
    if (Y<0) {
        Y = 0;
    }
    return CGRectMake(0, Y, width, height);
}
@end
