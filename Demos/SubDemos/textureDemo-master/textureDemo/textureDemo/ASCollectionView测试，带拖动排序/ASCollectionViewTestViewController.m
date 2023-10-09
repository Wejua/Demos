//
//  ASCollectionViewTestViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/28.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ASCollectionViewTestViewController.h"
#import "HeaderCellNode.h"


@interface ASCollectionViewTestViewController ()<ASCollectionDelegate,ASCollectionDataSource>
@property (nonatomic,strong)ASCollectionNode *collectionNode;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)UILongPressGestureRecognizer *longPressGesture;
@end

@implementation ASCollectionViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
#define ITEMSIZE CGSizeMake(180, 90)
#define FOOTERREFERENCESIZE CGSizeMake(50,50)
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake(180, 90);
    _flowLayout.footerReferenceSize = FOOTERREFERENCESIZE;
    _flowLayout.headerReferenceSize = FOOTERREFERENCESIZE;
    self.collectionNode = [[ASCollectionNode alloc]initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    [self.view addSubnode:_collectionNode];
//    collectionN.delegate = self;
    _collectionNode.dataSource = self;
    [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress)];
    [self.view addGestureRecognizer:_longPressGesture];
}
-(void)handleLongPress{
    UICollectionView *collectionView = _collectionNode.view;
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
- (BOOL)collectionNode:(ASCollectionNode *)collectionNode canMoveItemWithNode:(ASCellNode *)node
{
    return YES;
}
- (void)collectionNode:(ASCollectionNode *)collectionNode moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *model =  [WJViewModel sharedModel].data[sourceIndexPath.section][sourceIndexPath.row];
    [[WJViewModel sharedModel].data[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
    [[WJViewModel sharedModel].data[destinationIndexPath.section] insertObject:model atIndex:destinationIndexPath.row];
}
#pragma mark datasouse
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    return [WJViewModel sharedModel].data[section].count;
}
-(NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode{
    return [WJViewModel sharedModel].data.count;
}
- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASCellNode *cellNode = [ASCellNode new];
        cellNode.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        return cellNode;
    };
}
- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ASCellNode *cellNode = [ASCellNode new];
    cellNode.backgroundColor = [UIColor redColor];
    return cellNode;
}

@end
