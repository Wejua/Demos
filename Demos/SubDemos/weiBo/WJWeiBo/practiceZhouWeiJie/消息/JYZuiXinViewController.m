//
//  JYZuiXinViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYZuiXinViewController.h"
#import "WJXiaoXiTableViewCell.h"
#import "WJSegmentView.h"
#import "WJSegmentDetailView.h"
#import "WJSearchBar.h"
#import "WJHaiMeiYouTableViewCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface JYZuiXinViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)WJSegmentView *segmentView;
@property(weak,nonatomic)UIScrollView *scrollView;
@property(weak,nonatomic)UITableView *tableView1;
@property(weak,nonatomic)UITableView *tableView;
@property(copy,nonatomic)NSArray *imgNameArray;
@property(copy,nonatomic)NSArray *titleArray;
@property(copy,nonatomic)NSArray *detailTitleArray;
@property(weak,nonatomic)WJSearchBar *searchBar;
@property(weak,nonatomic)WJSearchBar *searchBar1;
@property(weak,nonatomic)UIView *HaiMeiTongZhiView;
@property(weak,nonatomic)UIRefreshControl *refresh;

@property(weak,nonatomic)MJRefreshNormalHeader *header1;
@property(weak,nonatomic)MJRefreshNormalHeader *header;

@property(nonatomic)CGFloat preOffsetX;
@property(nonatomic)bool hasDraged;
@end
#define tongZhiTag 1
#define liaoTianTag 2
#define scrollViewTag 3
@implementation JYZuiXinViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //左边列表
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(lieBiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *view = [[UIView alloc]initWithFrame:btn.bounds];
    [view addSubview:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    //中间通知和聊天
//    WJSegmentView *segmentView = [[WJSegmentView alloc]initWithTitles:@[@"通知",@"聊天"] frame:CGRectMake(0, 0, 150, 44)];
    WJSegmentView *segmentView = [[WJSegmentView alloc]initWithTitles:@[@"通知",@"聊天"] hasArrow:YES frame:CGRectMake(0, 0, 150, 44)];
    _segmentView = segmentView;
    self.navigationItem.titleView = segmentView;
    
    //添加scrollView滑动通知和聊天
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49)];
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, 1);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.tag = scrollViewTag;
    segmentView.detailView = scrollView;
    
    //UITabView通知
    UITableView *tableView1 = [[UITableView alloc]init];
    tableView1.tag  = tongZhiTag;
    _tableView1 = tableView1;
    tableView1.backgroundColor =[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollView addSubview:tableView1];
    tableView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [tableView1 registerClass:[WJXiaoXiTableViewCell class] forCellReuseIdentifier:@"WJXiaoXiTableViewCell"];
    [tableView1 registerClass:[WJHaiMeiYouTableViewCell class] forCellReuseIdentifier:@"WJHaiMeiYouTableViewCell"];
    //刷新
    MJRefreshNormalHeader *header1 = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_header1 endRefreshing];
    }];
    _header1 = header1;
    tableView1.mj_header = header1;
    header1.stateLabel.textColor = [UIColor lightGrayColor];
    header1.lastUpdatedTimeLabel.hidden = YES;
    [header1 setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [header1 setTitle:@"ddd" forState:MJRefreshStateWillRefresh];
    [header1 setTitle:@"释放更新" forState:MJRefreshStatePulling];
//    [header1 setTitle:@"nomoredata" forState:MJRefreshStateNoMoreData];
    [header1 setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header1.mj_x = 20;
    header1.arrowView.mj_size = CGSizeMake(10, 10);
    
    
    
    
  
    //UITabView聊天
    UITableView *tableView = [[UITableView alloc]init];
    tableView.tag  = liaoTianTag;
    _tableView = tableView;
    _tableView.backgroundColor =[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scrollView addSubview:tableView];
    tableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableView registerClass:[WJXiaoXiTableViewCell class] forCellReuseIdentifier:@"WJXiaoXiTableViewCell"];
    [tableView registerClass:[WJHaiMeiYouTableViewCell class] forCellReuseIdentifier:@"WJHaiMeiYouTableViewCell"];
    //刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_header endRefreshing];
    }];
    _header = header;
    tableView.mj_header = header;
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    //    [header setTitle:@"ddd" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    //    [header setTitle:@"nomoredata" forState:MJRefreshStateNoMoreData];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    header.mj_x = 20;

    //初始化
    _imgNameArray = @[@"chaojihuati",@"dingyuexiaoxi",@"leiijun",@"weibowenda",@"weiguanzhu",@"xiaomage",@"renmingRiBao",@"xinlang"];
    _titleArray = @[@"超级话题",@"微博问答",@"雷军",@"订阅消息",@"未关注人消息",@"新浪新闻",@"DOVE*🌹",@"小码哥教育"];
    _detailTitleArray = @[@"亲～感谢您关注",@"亲～感谢您关注",@"亲～感谢您关注",@"亲～感谢您关注",@"亲～感谢您关注",@"xiaomage",@"LOVE YOU",@"亲～感谢您关注"];   
}
-(void)lieBiaoClick{
    NSLog(@"%s",__func__);
}
#pragma mark -  datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag == tongZhiTag){
        return 1;
    }else{
        return _titleArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    NSInteger number = [tableView numberOfRowsInSection:0];
    identifier = number == 1? @"WJHaiMeiYouTableViewCell" : @"WJXiaoXiTableViewCell";
    WJXiaoXiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSInteger tag = tableView.tag;
    switch (tag) {
        case tongZhiTag://通知
            if (number == 1) {
            }
            break;
        default://聊天
            cell.imgV.image= [UIImage imageNamed:_imgNameArray[indexPath.item]];
            cell.titleLabel.text = _titleArray[indexPath.item];
            cell.detailLabel.text = _detailTitleArray[indexPath.item];
            cell.timeLabel.text = @"昨天";
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([tableView numberOfRowsInSection:0] == 1) ? SCREENSIZE.height-45-64-49 : 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //防止下面空很多
    tableView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    WJSearchBar *searchBar = [[WJSearchBar alloc]initWithFrame:CGRectZero];
    return searchBar;
}
//scrollview代理切换通知和聊天
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == scrollViewTag) {
        CGFloat x = scrollView.contentOffset.x;
        if ( x > SCREENSIZE.width || x < 0) return;
        if(_segmentView){
            _segmentView.refreshLine(x);
        }
    }
}
@end
