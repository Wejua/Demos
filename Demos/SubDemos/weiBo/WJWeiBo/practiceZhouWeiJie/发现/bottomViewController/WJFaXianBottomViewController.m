//
//  WJFaXianBottomViewController.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/5.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaXianBottomViewController.h"
#import "WJSegmentView.h"
#import "WJFaXianShiPinTableViewCell.h"
#import "WJFaXianTouTiaoTableViewCell.h"
#import "WJFaXianCollectionViewCell.h"
@interface WJFaXianBottomViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(weak,nonatomic)WJSegmentView *segmentV;
//@property(weak,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UICollectionView *collectionV;
@end

@implementation WJFaXianBottomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBackgoundColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanHui"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissClick)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationController.navigationBar.hidden = NO;
    
    //segmentV
    WJSegmentView *segmentV = [[WJSegmentView alloc]initWithTitles:@[@"视频",@"头条",@"榜单",@"北京"] hasArrow:NO frame:CGRectMake((SCREENSIZE.width-((47+56/3)*4+56/3))/2, 0, (47+56/3)*4+56/3, 44)];
    _segmentV = segmentV;
    self.navigationItem.titleView = segmentV;

    //添加collectionV滑动segmentView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,SCREENSIZE.height-64);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layout];
    _collectionV = collectionV;
    [self.view addSubview:collectionV];
    collectionV.pagingEnabled = YES;
    collectionV.dataSource = self;
    collectionV.delegate = self;
    [collectionV registerClass:[WJFaXianCollectionViewCell class] forCellWithReuseIdentifier:@"WJFaXianCollectionViewCell"];
    collectionV.backgroundColor = ViewBackgoundColor;
    collectionV.translatesAutoresizingMaskIntoConstraints = NO;
    
}


-(void)dismissClick{
    [self dismissViewControllerAnimated:NO completion:^{
        self.faXianViewScorllToTop();
    }];
//    [self.navigationController popViewControllerAnimated:NO];
//    self.faXianViewScorllToTop();
}

#pragma mark collctionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJFaXianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFaXianCollectionViewCell" forIndexPath:indexPath];
    cell.tableView.userInteractionEnabled = YES;
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
    return cell;
}
//scrollview代理切换segmentView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    //左滑dismiss 
    if (x<0) {
        [self dismissViewControllerAnimated:NO completion:^{
            self.faXianViewScorllToTop();
        }];
    }
//    NSLog(@"%f",x);
    if ( x > SCREENSIZE.width*3 || x < 0) return;
    _segmentV.refreshLine(x);
}
@end
