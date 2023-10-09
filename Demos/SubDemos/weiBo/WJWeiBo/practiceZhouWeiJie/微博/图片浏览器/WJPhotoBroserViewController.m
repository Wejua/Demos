//
//  WJPhotoBroserViewController.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJPhotoBroserViewController.h"
#import "WJPhotoBroserCollectionViewCell.h"


@interface WJPhotoBroserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(weak,nonatomic)UILabel *indexLabel;
@property(weak,nonatomic)UIButton *button;
@property(nonatomic)NSInteger index;
@property(weak,nonatomic)UIActivityIndicatorView *indicatorView;
@end

@implementation WJPhotoBroserViewController
//修改view宽度实现图片间距效果
-(void)loadView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.width += 20;
    view.frame = rect;
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    //点击关闭控制器
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
    [self.view addGestureRecognizer:tap];
    //长按弹出inputView
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick)];
    [self.view addGestureRecognizer:longPress];
}
#pragma mark collctionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _urls.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJPhotoBroserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJPhotoBroserCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = _urls[indexPath.row];
    url = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    WJPhotoBroserCollectionViewCell *cellz = (WJPhotoBroserCollectionViewCell *)cell;
    [cellz setUpImage:url index:indexPath.row];
     NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
}
//切换页面
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = (SCREENSIZE.width/2+scrollView.contentOffset.x)/SCREENSIZE.width+1;
    if (_index!=index) {
        if (_urls.count==1) {
            _indexLabel.text = @" ";
        }else if(index <= _urls.count){
            _indexLabel.text = [[NSString alloc]initWithFormat:@"%d/%lu",index,_urls.count];
            _index = index;
        }
    }
}
//转换到当前页
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_collectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    if(!_index && _urls.count > 1){
        _indexLabel.text = [[NSString alloc]initWithFormat:@"%d/%lu",1,_urls.count];
    }
}

-(void)viewClick{
    WJPhotoBroserCollectionViewCell *cell = [_collectionView visibleCells].lastObject;
    _indexPath = [_collectionView indexPathForCell:cell];
    CGRect rect = [cell.scrollView convertRect:cell.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    _fullScreeRect = rect;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonClick{
    //弹框
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //    _alertController = alertC;
    [alertC addAction:[UIAlertAction actionWithTitle:@"发送给好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveImage];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"转发微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"赞" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%s,thread:%@",__func__,[NSThread currentThread]);
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 保存到相册
- (void)saveImage{
    WJPhotoBroserCollectionViewCell *cell = (WJPhotoBroserCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[_collectionView indexPathsForVisibleItems].lastObject];
    UIImage *image = cell.imageView.image;
    if(!image) return;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    //加载菊花
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview:indicatorView];
    _indicatorView = indicatorView;
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //关闭菊花
    [_indicatorView stopAnimating];
    //提示
    NSString *message = (error==nil) ? @"保存成功" : @"保存失败";
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertC animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}
#pragma mark - 设置UI
-(void)setUpUI{
    //collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.view.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView = collectionV;
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.pagingEnabled = YES;
    collectionV.showsHorizontalScrollIndicator = NO;
    [collectionV registerClass:[WJPhotoBroserCollectionViewCell class] forCellWithReuseIdentifier:@"WJPhotoBroserCollectionViewCell"];
    collectionV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:collectionV];
    //中间索引
    UILabel *indexLabel = [[UILabel alloc]init];
    _indexLabel = indexLabel;
    indexLabel.translatesAutoresizingMaskIntoConstraints = NO;
    indexLabel.text = @" ";
    indexLabel.font = [UIFont systemFontOfSize:19];
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    [indexLabel sizeToFit];
    [self.view addSubview:indexLabel];
    [indexLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-20].active = YES;
    [indexLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30].active = YES;
    //右边选项
    UIButton *button = [[UIButton alloc]init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setImage:[UIImage imageNamed:@"xuanxiang"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-40].active = YES;
    [button.centerYAnchor constraintEqualToAnchor:indexLabel.centerYAnchor ].active = YES;
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
