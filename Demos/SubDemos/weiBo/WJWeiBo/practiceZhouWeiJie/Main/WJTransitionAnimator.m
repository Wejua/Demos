//
//  WJTransitionAnimator.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/9.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJTransitionAnimator.h"
@interface WJTransitionAnimator()
@property(nonatomic)bool hasPresented;
@end
@implementation WJTransitionAnimator
#pragma mark - UIViewControllerTransitioningDelegate
//实现这个方法present才能有效果，否则还是默认效果
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
//实现这个方法dismiss才能有效果，否则还是默认效果
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.1;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _hasPresented ? [self dismissAnimation:transitionContext] : [self presentAnimation:transitionContext];
}
-(void)presentAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    //获取要展示的控制器的view
    UIView *toView =  [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.alpha = 0;
    //获取容器视图
    [transitionContext.containerView addSubview:toView];
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        //生命转场结束
        [transitionContext completeTransition:YES];
        //标记
        _hasPresented = YES;
    }];
}
-(void)dismissAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0;
    } completion:^(BOOL finished) {
        //删除fromViewf
        [fromView removeFromSuperview];
        //生命转场结束
        [transitionContext completeTransition:YES];
        //标记
        _hasPresented = NO;
    }];
//    NSArray *cellArray = _collectionV.visibleCells;
//    NSArray *indexPaths = _collectionV.indexPathsForVisibleItems;
//    WJFaBuCollectionViewCell *cell;
//    NSIndexPath *indexPath;
//    for ( int i = 0;i<cellArray.count ;i++ ) {
//        cell = cellArray[i];
//        indexPath = indexPaths[i];
//        NSInteger row = cellArray.count-1-indexPath.row;
//        [UIView animateWithDuration:0.5 delay:0.02*row usingSpringWithDamping:0.65 initialSpringVelocity:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            if(i==0){
//                button.transform = CGAffineTransformRotate(button.transform, -M_PI_4);
//            }
//            cell.transform = CGAffineTransformTranslate(cell.transform, 0, [UIScreen mainScreen].bounds.size.height/2);
//        } completion:nil];
//    }
}
@end
