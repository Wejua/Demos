//
//  WJSegmentDetailView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/1.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJSegmentDetailView.h"

@implementation WJSegmentDetailView
-(instancetype)initWithFrame:(CGRect)frame titleView:(WJSegmentView *)titleView titleCount:(NSInteger)count{
    self = [super initWithFrame:frame];
    if(self){
        self.segmentView = titleView;
        super.delegate = self;
        self.contentSize = CGSizeMake(frame.size.width*count, 0);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        __weak typeof (self)weakSelf = self;
        _splitTitleViewDidClick = ^(NSInteger index){
            [weakSelf setContentOffset:CGPointMake(SCREENSIZE.width*index, 0) animated:NO];
        };
    }
    return self;
}
-(void)setDelegate:(id<UIScrollViewDelegate>)delegate{
    
}

//scrollview代理切换通知和聊天
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if ( x > SCREENSIZE.width || x < 0) return;
    if(_segmentView){
        _segmentView.refreshLine(x);
    }
}
@end
