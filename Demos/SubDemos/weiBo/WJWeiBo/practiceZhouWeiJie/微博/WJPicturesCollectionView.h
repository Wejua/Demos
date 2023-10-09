//
//  WJPicturesCollectionView.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/10.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJUserInfoModel.h"
@interface WJPicturesCollectionView : UICollectionView
@property(weak,nonatomic)WJUserInfoModel *model;
-(CGRect)fromRect:(NSIndexPath *)indexPath;
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath;
@end
