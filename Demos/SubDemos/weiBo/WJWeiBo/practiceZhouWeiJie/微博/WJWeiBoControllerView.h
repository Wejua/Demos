//
//  WJWeiBoControllerView.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSegmentDetailView.h"

@interface WJWeiBoControllerView : UIView
@property(copy,nonatomic)void(^didPaging)(CGFloat offsetX);
@property(weak,nonatomic)WJSegmentDetailView *segmentDetailView;
@property(weak,nonatomic)UIViewController *controller;

-(instancetype)initWithController:(UIViewController *)controller;
@end
