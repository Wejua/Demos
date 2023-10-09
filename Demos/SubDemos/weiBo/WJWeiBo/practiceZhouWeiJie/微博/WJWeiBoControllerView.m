//
//  WJWeiBoControllerView.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWeiBoControllerView.h"
#import "WJWeiBoCollectionViewCell.h"
#import "WJHttpManager.h"
#import "WJUserInfoModel.h"
#import "WJUserAccountModel.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
#import "SVProgressHUD.h"
#import "MJRefreshNormalHeader.h"

@interface WJWeiBoControllerView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(copy,nonatomic)NSMutableArray *cellModels;
@property(weak,nonatomic)UICollectionView *collectionV;
@property(strong,nonatomic)NSOperationQueue *queue;
//刷新
//@property(weak,nonatomic)UIRefreshControl *refresh;
//当前标题，关注/热门
@property(copy,nonatomic)NSString *currentTitle;
@property(weak,nonatomic)UIScrollView *scrollView;
@property(weak,nonatomic)WJSegmentView *titleView;
@property(weak,nonatomic)MJRefreshNormalHeader *refreshHeader;
@end
@implementation WJWeiBoControllerView
-(instancetype)initWithController:(UIViewController *)controller{
    self = [super init];
    if(self){
        _queue = [[NSOperationQueue alloc]init];
        _cellModels = [NSMutableArray array];
        _controller = controller;
        //下载完了刷新数据,通过监听队列的operationCount
        [_queue addObserver:self forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew context:@"queueObserve"];
        //加载数据
        [self loadData:nil];
        
        //中间关注和热门
        WJSegmentView *titleView = [[WJSegmentView alloc]initWithTitles:@[@"关注",@"热门"] hasArrow:YES frame:CGRectMake(0, 0, 150, 44)];
        _titleView = titleView;
        self.controller.navigationItem.titleView = titleView;
        
        //添加scrollView滑动关注和热门
        WJSegmentDetailView *segmentDetailView = [[WJSegmentDetailView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49) titleView:titleView titleCount:2];
        _segmentDetailView = segmentDetailView;
        segmentDetailView.segmentView = titleView;
        [self addSubview:segmentDetailView];
        titleView.detailView = segmentDetailView;
        
        //添加一个collectionview
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
//        layout.estimatedItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49) collectionViewLayout:layout];
        [segmentDetailView addSubview:collectionV];
        _collectionV = collectionV;
        collectionV.dataSource = self;
        collectionV.delegate = self;
        [collectionV registerClass:[WJWeiBoCollectionViewCell class] forCellWithReuseIdentifier:@"WeiBoCollectionViewCell"];
        collectionV.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        //接收通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(makePaging:) name:@"didClick" object:nil];
        //刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if(!_cellModels.count){
                [_refreshHeader endRefreshing];
                return;
            }
            [self loadData:@(0)];
//            WJUserInfoModel *model = _cellModels[0];
//            for (WJUserInfoModel *mode in _cellModels) {
////                NSLog(@"%lu",mode.model_id);
//            }
//            for (WJUserInfoModel *mode in _cellModels) {
////                NSLog(@"再一次：%lu",mode.model_id);
//            }
        }];
        _refreshHeader = header;
        _collectionV.mj_header = header;
        header.stateLabel.textColor = [UIColor lightGrayColor];
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        //    [header setTitle:@"ddd" forState:MJRefreshStateWillRefresh];
        [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
        //    [header setTitle:@"nomoredata" forState:MJRefreshStateNoMoreData];
        [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        header.mj_x = 20;
    }
    return self;
}
-(void)loadData:( NSNumber *_Nullable )since_id{
    if([WJUserAccountModel sharedUserAccount].access_token == nil) return;
    [_refreshHeader beginRefreshing];
    if(!since_id){
        [[AFHTTPSessionManager manager]GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:@{@"access_token":[WJUserAccountModel sharedUserAccount].access_token} progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _cellModels = [self makeModels:responseObject];
            //下载所有小图片确定宽高
            for (WJUserInfoModel *model in _cellModels) {
                if(model.pic_urls.count){
                    [_queue addOperationWithBlock:^{
                        [[SDWebImageManager sharedManager] loadImageWithURL:model.pic_urls[0] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                        }];
                    }];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }else{
        [[AFHTTPSessionManager manager]GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:@{@"access_token":[WJUserAccountModel sharedUserAccount].access_token,@"since_id":since_id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableArray *array = [self makeModels:responseObject];
            _cellModels = array;
            //下载所有小图片确定宽高
            for (WJUserInfoModel *model in array) {
                if(model.pic_urls.count){
                    [_queue addOperationWithBlock:^{
                        [[SDWebImageManager sharedManager] loadImageWithURL:model.pic_urls[0] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                        }];
                    }];
                }
            }
            //提示更新了多少条微博
//            NSLog(@"更新了%lu条微博",array.count);
        } failure:nil];
    }
//    [_refreshHeader endRefreshing];
}
//监听queue
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == @"queueObserve") {
        int count = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        if(count == 0){
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                if(_cellModels.count >140){
                    
                }
                [_collectionV reloadData];
                [_refreshHeader endRefreshing];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//接收到通知翻页
-(void)makePaging:(NSNotification *)notification{
    NSNumber *index = notification.userInfo[@"index"];
    CGSize size = _scrollView.bounds.size;
    if(index.intValue == 0){
        [_collectionV setContentOffset:CGPointMake(_collectionV.contentOffset.x, _collectionV.contentOffset.y) animated:NO];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        [_collectionV setContentOffset:CGPointMake(_collectionV.contentOffset.x, _collectionV.contentOffset.y) animated:NO];
        [_scrollView setContentOffset:CGPointMake(size.width, 0)];
    }
}
-(NSMutableArray *)makeModels:(NSDictionary *)dicData{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *statuses = dicData[@"statuses"];
    for (NSDictionary *dic in statuses) {
        WJUserInfoModel *model =  [[WJUserInfoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
#pragma mark - dataSource
//1，线调用外面大cell数据源方法获取有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cellModels.count;
}
//5，出列大cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJWeiBoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeiBoCollectionViewCell" forIndexPath:indexPath];
    //cell设置数据
    cell.model = _cellModels[indexPath.item];
    return cell;
}
//获取每一行的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJUserInfoModel *model = _cellModels[indexPath.item];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, model.cellHight);
}
@end
