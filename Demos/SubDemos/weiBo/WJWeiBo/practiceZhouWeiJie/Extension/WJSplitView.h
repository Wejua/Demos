//
//  WJSplitView.h
//  BuDeJieWJ
//
//  Created by WJMac on 2018/2/2.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    WJSplitViewAlignmentVertical = 0,
    WJSplitViewAlignmentHorizontal,
}WJSplitViewAlignment;
@protocol WJJingHuaControllerViewDelegate<UICollectionViewDelegate,UIScrollViewDelegate>
@end
@interface WJSplitView : UIView 
@property(weak,nonatomic) UICollectionView *detailView;
@property(weak,nonatomic)UIScrollView *titleBar;

//@property(nonatomic)float titleBarHeight;
@property(nonatomic)WJSplitViewAlignment alignment;
@property(copy,nonatomic)NSArray<NSString *> *titles;
@property(copy,nonatomic)NSMutableArray *titleButtonArray;
@property(readonly,nonatomic)int previousIdex;
@property(weak,nonatomic)id<WJJingHuaControllerViewDelegate> delegate;
@end
