//
//  JYJingHuaViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//


#import "WJWeiBoViewController.h"
#import "WJSegmentView.h"
#import "WJWeiBoLoginViewController.h"
#import "WJUserAccountModel.h"
#import "WJWeiBoControllerView.h"
#import "WJPhotoBroserViewController.h"
#import "WJRetweetedView.h"
#import "SDImageCache.h"

@interface WJWeiBoViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property(weak,nonatomic)WJWeiBoControllerView *controllerView;
@property(nonatomic)bool hasPresented;
@property(nonatomic)CGRect fromRect;
@property(nonatomic)CGRect fullScreenRect;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(copy,nonatomic)NSArray *urls;
@property(weak,nonatomic)WJPicturesCollectionView *object;

@end
@implementation WJWeiBoViewController
-(void)loadView{
    WJWeiBoControllerView *view = [[WJWeiBoControllerView alloc]initWithController:self];
    _controllerView = view;
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
    //没有uid就是新对象，document里面没有存,或者token过期了
    if(![WJUserAccountModel sharedUserAccount].access_token || [[WJUserAccountModel sharedUserAccount].expiresDate compare:[NSDate date]] == NSOrderedAscending){
        //左边注册按钮（未登录状态）//没有uid就是新对象，document里面没有存
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick)];
        //右边登录（未登录状态）
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginClick)];
    }
    //接收retweetedCollectionView的点击
    __weak typeof (self)weakself = self;
    [[NSNotificationCenter defaultCenter]addObserverForName:@"retweetedCollectionViewDidSelectedItem" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof (weakself)strongSelf = weakself;
        //转换到图片浏览器控制器
        WJPhotoBroserViewController *vc = [[WJPhotoBroserViewController alloc]init];
        vc.transitioningDelegate = self;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.urls = note.userInfo[@"imageUrls"];
        
        NSIndexPath *indexPath = note.userInfo[@"indexPath"];
        vc.indexPath = indexPath;
        self.indexPath = indexPath;
        self.urls =note.userInfo[@"imageUrls"];
        WJPicturesCollectionView *view = note.userInfo[@"object"];
        _object = view;
        _fromRect = [view fromRect:indexPath];
        _fullScreenRect = [view fullScreeRect:indexPath];
        [strongSelf presentViewController:vc animated:YES completion:nil];
    }];
}
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
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _hasPresented ? [self dismissAnimation:transitionContext] : [self presentAnimation:transitionContext];
}
-(void)presentAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    //获取要展示的控制器的view
    UIView *toView =  [transitionContext viewForKey:UITransitionContextToViewKey];
    WJPhotoBroserViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView.alpha = 0;
    //获取容器视图
    [transitionContext.containerView addSubview:toView];
    //添加fromRect
    //获取图片
    NSString *url = _urls[_indexPath.row];
    NSString *key = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:key];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = _fromRect;
    //
    toVC.collectionView.hidden = YES;
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
        imageView.frame = _fullScreenRect;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        toVC.collectionView.hidden = NO;
        //生命转场结束
        [transitionContext completeTransition:YES];
        //标记
        _hasPresented = YES;
    }];
}
-(void)dismissAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    WJPhotoBroserViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //添加fromRect
    //获取图片
    NSString *url = _urls[fromVC.indexPath.row];
    NSString *key = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:key];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [transitionContext.containerView addSubview:imageView];
    imageView.frame = fromVC.fullScreeRect;
    //'
    fromVC.collectionView.hidden = YES;
    //动画
    _fromRect = [_object fromRect:fromVC.indexPath];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0;
        imageView.frame = _fromRect;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        //删除fromViewf
        [fromView removeFromSuperview];
        //生命转场结束
        [transitionContext completeTransition:YES];
        //标记
        _hasPresented = NO;
    }];
}
//注册点击
-(void)registerClick{
}
//登录点击
-(void)loginClick{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[WJWeiBoLoginViewController alloc]init]];
    [self presentViewController:nav animated:YES completion:nil];
}
-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"retweetedCollectionViewDidSelectedItem" object:nil];
}
@end
