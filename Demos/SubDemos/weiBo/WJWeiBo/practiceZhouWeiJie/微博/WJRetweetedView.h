//
//  WJPhotoCollectionView.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/16.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJUserInfoModel.h"
#import "WJPicturesCollectionView.h"

@interface WJRetweetedView : UIView
@property(weak,nonatomic)WJUserInfoModel *model;
@property(weak,nonatomic)UILabel *retweetedLabel;
@property(weak,nonatomic)WJPicturesCollectionView *retweetedImgCltV;
-(CGRect)fromRect:(NSIndexPath *)indexPath;
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath;
//@property(strong,nonatomic)NSMutableArray *indexPaths;
@end

