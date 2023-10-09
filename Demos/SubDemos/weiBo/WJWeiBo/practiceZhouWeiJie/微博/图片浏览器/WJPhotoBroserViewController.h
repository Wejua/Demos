//
//  WJPhotoBroserViewController.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPhotoBroserViewController : UIViewController

@property(copy,nonatomic)NSArray *urls;
@property(nonatomic)NSIndexPath *indexPath;

@property(weak,nonatomic)UICollectionView *collectionView;
@property(nonatomic)CGRect fullScreeRect;
@end
