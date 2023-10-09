//
//  WJCollectionViewCell.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/9.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJUserInfoModel.h"
#import "WJPicturesCollectionView.h"

@interface WJWeiBoCollectionViewCell : UICollectionViewCell
@property(weak,nonatomic)WJUserInfoModel *model;
@property(nonatomic)CGFloat height;
@property(weak,nonatomic)UIImageView *zhuanFaImg;
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath;
-(CGRect)fromRect:(NSIndexPath *)indexPath;
@end
