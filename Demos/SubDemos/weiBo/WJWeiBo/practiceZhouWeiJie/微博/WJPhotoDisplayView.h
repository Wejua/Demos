//
//  WJPhotoDisplayView.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/11.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJUserInfoModel.h"

@interface WJPhotoDisplayView : UIView
@property(weak,nonatomic)WJUserInfoModel *model;
@property(weak,nonatomic)UICollectionView *retweetedImgCltV;
-(void)reloadData;
-(CGRect)fromRect:(NSIndexPath *)indexPath;
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath;
@end
