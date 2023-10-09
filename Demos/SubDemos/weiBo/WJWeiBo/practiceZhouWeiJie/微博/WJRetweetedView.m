//
//  WJPhotoCollectionView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/16.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJRetweetedView.h"
#import "WJCollectionViewFlowLayout.h"
#import "MiddleCollectionViewCell.h"
#import "STPhotoBrowserController.h"
#import "SDWebImageManager.h"
@interface WJRetweetedView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@end
@implementation WJRetweetedView
-(instancetype)init{
    self = [super init];
    if(self){
        //中间转发界面
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        //retweetedLabel
        UILabel *retweetedLabel = [[UILabel alloc]init];
        _retweetedLabel = retweetedLabel;
//        retweetedLabel.text = @"song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni ";
        retweetedLabel.numberOfLines = 0;
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//        paragraphStyle.lineSpacing = 0.5;
//        paragraphStyle.alignment = NSTextAlignmentLeft;
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *dic = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f,NSFontAttributeName:[UIFont systemFontOfSize:15]};
//        retweetedLabel.attributedText = [[NSAttributedString alloc]initWithString:@"song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni " attributes:dic];
//        retweetedLabel.font = [UIFont systemFontOfSize:15];
        retweetedLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
//        retweetedLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:retweetedLabel];
        //retweetedImgCltV
        WJCollectionViewFlowLayout *retweetedLayout = [[WJCollectionViewFlowLayout alloc]init];//CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)
        retweetedLayout.minimumInteritemSpacing = space;
        retweetedLayout.minimumLineSpacing = space;
        WJPicturesCollectionView *retweetedImgCltV = [[WJPicturesCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:retweetedLayout];
        [retweetedImgCltV registerClass:[MiddleCollectionViewCell class] forCellWithReuseIdentifier:@"MiddleCollectionViewCell"];
        retweetedImgCltV.delegate = self;
        retweetedImgCltV.dataSource = self;
        _retweetedImgCltV = retweetedImgCltV;
        retweetedImgCltV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        retweetedImgCltV.scrollEnabled = NO;
        [self addSubview:retweetedImgCltV];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _retweetedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _retweetedImgCltV.translatesAutoresizingMaskIntoConstraints = NO;
    //top
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:insets]];
    //left
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    //bottom
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_retweetedImgCltV attribute:NSLayoutAttributeTop multiplier:1.0 constant:-insets]];
    //right
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    //_retweetedImgCltV
    //left
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedImgCltV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    //bottom
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedImgCltV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets]];
    //right
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedImgCltV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.pic_urls.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MiddleCollectionViewCell" forIndexPath:indexPath];
    [cell setModel:_model.pic_urls[indexPath.item]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat NineImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets-space*2)/3;
//    CGFloat oneImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets)/2;
    if(_model.pic_urls.count == 1){
        return _model.oneImgeSize;
    }else{
        return CGSizeMake(NineImgWidth,NineImgWidth);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //通知控制器切换图片浏览器界面
//    UIView *view = [[UIView alloc]init];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//    view.frame = [self fromRect:indexPath];
//    view.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:0.5];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"retweetedCollectionViewDidSelectedItem" object:nil userInfo:@{@"indexPath":indexPath,@"imageUrls":_model.pic_urls,@"object":_retweetedImgCltV}];
}
//计算相对窗口位置
-(CGRect)fromRect:(NSIndexPath *)indexPath{
    CGRect frame = [_retweetedImgCltV cellForItemAtIndexPath:indexPath].frame;
    CGRect rect =[_retweetedImgCltV convertRect:frame toView:[UIApplication sharedApplication].keyWindow];
    return rect;
}
//-(NSMutableArray *)fromRects{
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i<_model.pic_urls.count; i++) {
//        CGRect frame = [_retweetedImgCltV cellForItemAtIndexPath:[NSIndexPath indexPathWithIndex:i]].frame;
//        CGRect rect =[_retweetedImgCltV convertRect:frame toView:[UIApplication sharedApplication].keyWindow];
//        [array addObject:rect];
//    }
//}
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
