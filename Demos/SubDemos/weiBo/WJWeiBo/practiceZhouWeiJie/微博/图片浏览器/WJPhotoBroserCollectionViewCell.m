//
//  WJPhotoBroserCollectionViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJPhotoBroserCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
//#import "UIImageView+AFNetworking.h"
@interface WJPhotoBroserCollectionViewCell()<UIScrollViewDelegate>
@property(weak,nonatomic)UIActivityIndicatorView *indicatorView;
@end
@implementation WJPhotoBroserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
        _scrollView = scrollView;
        [self.contentView addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 2.0;
        
        //imageView
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
        [scrollView addSubview:imageView];
        
        //加载菊花
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
        indicatorView.center = scrollView.center;
        
    }
    return self;
}
-(void)setUpImage:(NSString *)url index:(NSInteger)index{
    //重置scrollView
    [self resetScrollView];
    //显示菊花
    [_indicatorView startAnimating];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoBroserPlaceholdImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error != nil) {
            [SVProgressHUD showInfoWithStatus:@"您的网络不给力"];
            return ;
        }
        //结束菊花
        [_indicatorView stopAnimating];
        //设置位置
        [self setImagePosition];
    }];
//    NSLog(@"");
}
-(void)resetScrollView{
    _scrollView.contentSize = CGSizeZero;
    _scrollView.contentInset = UIEdgeInsetsZero;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.zoomScale = 1.0;
}
//计算图片展示宽高比
-(CGSize)displaySize:(UIImage *)image{
    CGFloat scale = image.size.height/image.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.width*scale;
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, height);
}
-(void)setImagePosition{
    CGSize size = [self displaySize:_imageView.image];
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    if (size.height<[UIScreen mainScreen].bounds.size.height) {
        CGFloat Y = ([UIScreen mainScreen].bounds.size.height-size.height)/2;
        _scrollView.contentInset = UIEdgeInsetsMake(Y, 0, 0, 0);
    }else{
        _scrollView.contentSize = size;
    }
}
#pragma mark delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //调整位置，通过inset
    CGFloat offsetY = (SCREENSIZE.height - _imageView.frame.size.height)/2;
    CGFloat offsetX = (SCREENSIZE.width - _imageView.frame.size.width)/2;
    //避免小于零部分看不到
    offsetX = offsetX < 0 ? 0 : offsetX;
    offsetY = offsetY < 0 ? 0 : offsetY;
    _scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, 0, 0);
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{

}

@end
