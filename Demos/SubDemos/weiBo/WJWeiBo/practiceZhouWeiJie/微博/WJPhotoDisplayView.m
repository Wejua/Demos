//
//  WJPhotoDisplayView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/11.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJPhotoDisplayView.h"
#import "WJCollectionViewFlowLayout.h"
#import "MiddleCollectionViewCell.h"
#import "SDImageCache.h"
@interface WJPhotoDisplayView()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation WJPhotoDisplayView
- (instancetype)init
{
    self = [super init];
    if (self) {
        //retweetedImgCltV
        WJCollectionViewFlowLayout *retweetedLayout = [[WJCollectionViewFlowLayout alloc]init];//CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)
        retweetedLayout.minimumInteritemSpacing = space;
        retweetedLayout.minimumLineSpacing = space;
        UICollectionView *retweetedImgCltV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:retweetedLayout];
        [retweetedImgCltV registerClass:[MiddleCollectionViewCell class] forCellWithReuseIdentifier:@"MiddleCollectionViewCell"];
        retweetedImgCltV.delegate = self;
        retweetedImgCltV.dataSource = self;
        _retweetedImgCltV.translatesAutoresizingMaskIntoConstraints = NO;
        _retweetedImgCltV = retweetedImgCltV;
        retweetedImgCltV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        retweetedImgCltV.scrollEnabled = NO;
        [self addSubview:retweetedImgCltV];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //_retweetedImgCltV
    [_retweetedImgCltV.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_retweetedImgCltV.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_retweetedImgCltV.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_retweetedImgCltV.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
}
-(void)reloadData{
    [_retweetedImgCltV reloadData];
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"retweetedCollectionViewDidSelectedItem" object:nil userInfo:@{@"indexPath":indexPath,@"imageUrls":_model.pic_urls,@"object":self}];
}
//计算相对窗口位置
-(CGRect)fromRect:(NSIndexPath *)indexPath{
    CGRect frame = [_retweetedImgCltV cellForItemAtIndexPath:indexPath].frame;
    CGRect rect =[_retweetedImgCltV convertRect:frame toView:[UIApplication sharedApplication].keyWindow];
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
