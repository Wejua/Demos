//
//  ViewController.m
//  书架Demo
//
//  Created by tommy on 15/11/30.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "BookCell.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,BookCellDelegate>
@property (nonatomic,assign)BOOL isEditingBook;
@property (nonatomic,weak)UICollectionView *bookShelf;
@property (nonatomic,assign)NSIndexPath *indexPath;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController
#define itemsMagin ([UIScreen mainScreen].bounds.size.width/20)
#define itemsLineMagin (([UIScreen mainScreen].bounds.size.height-64)/10)
#define viewSize ([UIScreen mainScreen].bounds.size)
#define itemHeight  (((viewSize.height-64)-itemsLineMagin*4)/3)
#define itemWidth  ((viewSize.width-itemsMagin*2*4)/3)
#define reuseID @"bookCell"
#define sectionCount 1
#define bookShelfFrame CGRectMake(0, 64, viewSize.width, viewSize.height-64)

//加载数据
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runAnimateKeyframes];//关键帧动画另外加的
    
//    //添加collectionView
//    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
//    UICollectionView *bookShelf = [[UICollectionView alloc]initWithFrame:bookShelfFrame collectionViewLayout:layOut];
//    self.bookShelf = bookShelf;
//    [self.view addSubview:bookShelf];
//
//    //设置代理和数据源
//    bookShelf.delegate = self;
//    bookShelf.dataSource = self;
//
//    //注册类
//    [bookShelf registerClass:[BookCell class] forCellWithReuseIdentifier:reuseID];
//
//    //设置属性
//    layOut.itemSize = CGSizeMake(itemWidth,itemHeight);
//    layOut.minimumInteritemSpacing = itemsMagin;
//    layOut.minimumLineSpacing = itemsLineMagin;
//    layOut.sectionInset = UIEdgeInsetsMake(itemsLineMagin, itemsMagin*2, 0, itemsMagin*2);
//    bookShelf.backgroundColor = [UIColor whiteColor];
//
//    //编辑按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(changeToEditingState)];
//
//    //添加书架背景
//    for (int i=0;i<sectionCount*9 ; i++) {
//        UIImageView *backGroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ebook_rackBag"]];
//        [self.bookShelf addSubview:backGroundImg];
//        CGFloat backGroundImgY =(itemHeight+itemsLineMagin)*(i+1)-backGroundImg.image.size.height+35;
//        backGroundImg.frame = CGRectMake(4,backGroundImgY ,viewSize.width-4*2, backGroundImg.image.size.height);
//    }
}
- (void)runAnimateKeyframes {
    
    /**
     *  relativeDuration  动画在什么时候开始
     *  relativeStartTime 动画所持续的时间
     */
    
    [UIView animateKeyframesWithDuration:6.f
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor redColor];
                                                                }];

                                  [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor yellowColor];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor greenColor];                                                                }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  [self runAnimateKeyframes];
                              }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.bookShelf.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)changeToEditingState{
    self.isEditingBook= !self.isEditingBook;
    [self.bookShelf reloadData];
}
//-(void)buttonClick{
//    NSLog(@"buttonClick");
//    if (self.indexPath) {
//        [self.bookShelf performBatchUpdates:^{
//
//        } completion:nil];
//    }
//    
//}

#pragma dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return sectionCount;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.delegate = self;
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
//    [cell.removeBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    if (self.isEditingBook) {
        cell.removeImgV.hidden = NO;
    }else{
        cell.removeImgV.hidden = YES;
    }
    
    return cell;
}
//-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//}

#pragma delegate
//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"--1--didDeselectItemAtIndexPath");
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    self.indexPath = indexPath;
//    if (self.isEditingBook) {
//        [self.dataArray removeObjectAtIndex:self.indexPath.row];
//        [self.bookShelf deleteItemsAtIndexPaths:@[self.indexPath]];
//    }
//
////    NSLog(@"%@",self.indexPath);
////    NSLog(@"data=%@",self.dataArray);
//}
//-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
////    NSLog(@"--3--didEndDisplayingCell");
//}
//-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"--4--didEndDisplayingSupplementaryView");
//}
-(void)didClickBtn{
    NSLog(@"%s",__func__);
//    if (self.isEditingBook) {
//        [self.dataArray removeObjectAtIndex:self.indexPath.row];
//        [self.bookShelf deleteItemsAtIndexPaths:@[self.indexPath]];
//    }
}

@end
