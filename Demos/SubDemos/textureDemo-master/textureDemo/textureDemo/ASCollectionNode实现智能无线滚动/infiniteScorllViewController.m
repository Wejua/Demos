//
//  infiniteScorllViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/9.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "infiniteScorllViewController.h"
#import "LoadingNode.h"
#import "BlurbNode.h"

static const NSInteger kBatchSize = 5;
static const NSTimeInterval kWebResponseDelay = 1.0;



@interface infiniteScorllViewController ()<ASCollectionDataSource,ASCollectionDelegateFlowLayout>
@property (nonatomic,strong)ASCollectionNode *collectionNode;
@property (nonatomic,strong)NSMutableArray *data;
@end

@implementation infiniteScorllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    _data = [NSMutableArray array];
    //添加子控件并布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(380, 360);
    _collectionNode = [[ASCollectionNode alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubnode:_collectionNode];
    _collectionNode.delegate = self;
    _collectionNode.dataSource = self;
    [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    [_collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    //目前没有感觉到下面两段设置的效果，没有这两段也行
    ASRangeTuningParameters preloadTuning;
    preloadTuning.leadingBufferScreenfuls = 3;
    preloadTuning.trailingBufferScreenfuls = 3;
    [_collectionNode setTuningParameters:preloadTuning forRangeType:ASLayoutRangeTypePreload];
    
    ASRangeTuningParameters displayTuning;
    displayTuning.leadingBufferScreenfuls = 2;
    displayTuning.trailingBufferScreenfuls = 2;
    [_collectionNode setTuningParameters:displayTuning forRangeType:ASLayoutRangeTypeDisplay];
    
    [self fetchMoreDataWithCompletion:nil];
    
}
-(void)fetchMoreDataWithCompletion:(void(^)(BOOL finished))completion{
    if (kWebResponseDelay) {
        __weak typeof (self) weakself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kWebResponseDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            infiniteScorllViewController *strongself = weakself;
            if(strongself){
                [strongself dealDataWithCompletion:completion];
            }else{
                NSLog(@"ViewController is nil - won't update collection");
            }
        });
    }else{
        [self dealDataWithCompletion:completion];
    }

}
-(void)dealDataWithCompletion:(void(^)(BOOL finished))completion{
    [_collectionNode performBatchAnimated:YES updates:^{
        NSArray *array = [self getMoreDataWithDataCount:kBatchSize];
        [_data addObjectsFromArray:array];
        NSArray *indexpaths = [self getIndexPathFromArray:array];
        [_collectionNode insertItemsAtIndexPaths:indexpaths];
    } completion:completion];
}
-(NSArray *)getMoreDataWithDataCount:(NSInteger)count{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        [array addObject:[NSObject new]];
    }
    return array;
}
-(NSArray *)getIndexPathFromArray:(NSArray *)array{
    NSMutableArray *indexpaths = [NSMutableArray array];
    for (NSObject *obj in array) {
        NSInteger index = [_data indexOfObject:obj];
        NSAssert(index!=NSNotFound, @"数据为空（可能是没有初始化数组），数组不在_data中");
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:index inSection:0];
        [indexpaths addObject:indexpath];
    }
    return indexpaths;
}

#pragma mark - ASCollectionViewDatasource
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}
- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode{
    return 1;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASCellNode *cellNode = [ASCellNode new];
        cellNode.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        return cellNode;
    };
}
- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        return [BlurbNode new];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section == 0) {
        return [[LoadingNode alloc] init];//提供一个刷新指示器（UIActivityIndicatorView)每次init时就startAnimating就行了
    }
    return nil;
}
#pragma mark ASCollectionViewDelegate
//- (id)collectionNode:(ASCollectionNode *)collectionNode nodeModelForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return _data[indexPath.item];
//}
-(void)collectionNode:(ASCollectionNode *)collectionNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [self fetchMoreDataWithCompletion:^(BOOL finished) {
        [context completeBatchFetching:YES];
    }];
}
#pragma mark - ASCollectionDelegateFlowLayout

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return ASSizeRangeUnconstrained;
    } else {
        return ASSizeRangeZero;
    }
}
//实现ASCollectionDelegateFlowLayout的这个方法指定footer的大小
- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode sizeRangeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return ASSizeRangeUnconstrained;
    } else {
        return ASSizeRangeZero;
    }
}

@end
