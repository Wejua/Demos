//
//  UICollectionViewTestViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/28.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "UICollectionViewTestViewController.h"
#import "WJCollectionViewCell.h"
#import "WJCollectionViewSupplementaryCellCollectionViewCell.h"
#import "WJViewModel.h"

@interface UICollectionViewTestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak)UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic,weak)UICollectionView *collectionView;
@end

@implementation UICollectionViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    [self UICollectionViewTest];
}
-(void)UICollectionViewTest{
    //添加长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress)];
    _longPressGesture = longPressGesture;
    [self.view addGestureRecognizer:longPressGesture];
#define ITEMSIZE CGSizeMake(180, 90)
#define FOOTERREFERENCESIZE CGSizeMake(50,50)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(180, 90);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.footerReferenceSize = FOOTERREFERENCESIZE;
    layout.headerReferenceSize = FOOTERREFERENCESIZE;
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView = collectionV;
    [self.view addSubview:collectionV];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [collectionV registerClass:[WJCollectionViewCell class] forCellWithReuseIdentifier:@"WJCollectionViewCell"];
    [collectionV registerClass:[WJCollectionViewSupplementaryCellCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCollectionViewSupplementaryCellCollectionViewCell"];
    [collectionV registerClass:[WJCollectionViewSupplementaryCellCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJCollectionViewSupplementaryCellCollectionViewCell"];
    
}
- (void)handleLongPress
{
    UICollectionView *collectionView = _collectionView;
    CGPoint location = [self.longPressGesture locationInView:collectionView];
    switch (self.longPressGesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *indexPath = [collectionView indexPathForItemAtPoint:location];
            if (indexPath) {
                [collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
            [collectionView updateInteractiveMovementTargetPosition:location];
            break;
        case UIGestureRecognizerStateEnded:
            [collectionView endInteractiveMovement];
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            [collectionView cancelInteractiveMovement];
            break;
        case UIGestureRecognizerStatePossible:
            // nop
            break;
    }
}
#pragma mark - 实现排序要重写的两个方法
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    NSString *model =  [WJViewModel sharedModel].data[sourceIndexPath.section][sourceIndexPath.row];
    [[WJViewModel sharedModel].data[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
    [[WJViewModel sharedModel].data[destinationIndexPath.section] insertObject:model atIndex:destinationIndexPath.row];
}
#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [WJViewModel sharedModel].data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [WJViewModel sharedModel].data[section].count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    [cell setUPData:indexPath];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *text;
    WJCollectionViewSupplementaryCellCollectionViewCell *supplementaryCell;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        text = @"header";
        supplementaryCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCollectionViewSupplementaryCellCollectionViewCell" forIndexPath:indexPath];
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        text = @"footer";
        supplementaryCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJCollectionViewSupplementaryCellCollectionViewCell" forIndexPath:indexPath];
    }
    supplementaryCell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    [supplementaryCell setUPData:indexPath];
    return supplementaryCell;
}





@end
