//
//  WJSegmentDetailView.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/1.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSegmentView.h"

@interface WJSegmentDetailView : UIScrollView<UIScrollViewDelegate>
@property(weak,nonatomic) WJSegmentView* segmentView;
@property(copy,nonatomic)void(^splitTitleViewDidClick)(NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame titleView:(WJSegmentView *)titleView titleCount:(NSInteger)count;
@end
