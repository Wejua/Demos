//
//  WJSegment.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/6.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WJSegmentDetailView.h"
//@class WJSegmentDetailView;

@interface WJSegmentView : UIView
@property(copy,nonatomic)void(^refreshLine)(CGFloat offsetX);
-(instancetype)initWithTitles:(NSArray <NSString *> *)titles hasArrow:(BOOL)hasArrow frame:(CGRect)frame;
@property(copy,nonatomic)NSMutableArray *buttons;
@property(weak,nonatomic)UIScrollView *detailView;
@end
