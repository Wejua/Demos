//
//  WJFaXianTableViewController.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/27.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaXianViewController.h"
#import "WJFaXainSearchBar.h"
#import "WJFaXianLunBoTableViewCell.h"
#import "WJFaBubuttonsTableViewCell.h"
#import "WJFaBuThreeTableViewCell.h"
#import "WJSecendTableViewCell.h"
#import "WJSegmentView.h"
#import "WJFaXianBottomViewController.h"
#import "JYNavigationViewController.h"

@interface WJFaXianViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)UITableView *tableView;
@property(strong,nonatomic)WJSegmentView *segmentV;
@property(weak,nonatomic)WJFaXainSearchBar *searchBar;
@property(nonatomic)CGRect searchBarRect;
@property(nonatomic)bool hasPresentBottomViewcontroller;
@property(strong,nonatomic)NSLock *lock;
@end

@implementation WJFaXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBackgoundColor;
    
    //segmentV
    WJSegmentView *segmentV = [[WJSegmentView alloc]initWithTitles:@[@"视频",@"头条",@"榜单",@"北京"] hasArrow:NO frame:CGRectMake((SCREENSIZE.width-((47+56/3)*4+56/3))/2, 0, (47+56/3)*4+56/3, 44)];
    _segmentV = segmentV;
    
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0  );
    _tableView = tableView;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[WJFaXianLunBoTableViewCell class] forCellReuseIdentifier:@"WJFaXianLunBoTableViewCell"];
    [_tableView registerClass:[WJFaBubuttonsTableViewCell class] forCellReuseIdentifier:@"WJFaBubuttonsTableViewCell"];
    [_tableView registerClass:[WJFaBuThreeTableViewCell class] forCellReuseIdentifier:@"WJFaBuThreeTableViewCell"];
    [_tableView registerClass:[WJSecendTableViewCell class] forCellReuseIdentifier:@"WJSecendTableViewCell"];
    
    //搜索框
    WJFaXainSearchBar *searchBar = [[WJFaXainSearchBar alloc]initWithFrame:CGRectMake(0, 20, 414, 45)];
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    NSLog(@"height:%f",height);
//    if(height == 812){
//        searchBar.frame = CGRectMake(0, 64, 414, 45);
//    }
    [searchBar setBackgroundColor:[UIColor whiteColor]];
    _searchBar = searchBar;
    [self.view addSubview:searchBar];
    
    _searchBarRect = searchBar.frame;
    //加锁
    NSLock *lock = [[NSLock alloc]init];
    _lock = lock;

}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        default:
            return 45;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:_segmentV];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 4;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                WJFaXianLunBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJFaXianLunBoTableViewCell" forIndexPath:indexPath];
                return cell;
            }else if(indexPath.row == 1){
                WJFaBubuttonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJFaBubuttonsTableViewCell" forIndexPath:indexPath];
                return cell;
            }else{
                WJFaBuThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJFaBuThreeTableViewCell" forIndexPath:indexPath];
                if (indexPath.row == 2) {
                    cell.leftImgV.image = [UIImage imageNamed:@"pichubukeneng"];
                    cell.leftLabel.text = @"#劈出不可能#";
                    cell.rightImgV.image = [UIImage imageNamed:@"ajiao"];
                    cell.rightLabel.text = @"#阿胶疗效引争议#";
                }else if(indexPath.row == 3){
                    cell.leftImgV.image = [UIImage imageNamed:@"laolunsi"];
                    cell.leftLabel.text = @"#劳伦斯世界体育奖#";
                    cell.rightImgV.image = [UIImage imageNamed:@"renmenchaojihuati"];
                    cell.rightLabel.text = @"热门/超级话题";
                }
                return cell;
            }
            break;
    
        default:{
            WJSecendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSecendTableViewCell" forIndexPath:indexPath];
            cell.segmentView = _segmentV;
            return cell;}
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
            if (indexPath.row == 0) {
                return 110;
            }else if(indexPath.row == 1){
                return 150;
            }else{
                return 30;
            }
            break;
        default:
            return SCREENSIZE.height-64;
            break;
    }
}
//跟踪tableView的滑动隐藏搜索栏
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat Y = scrollView.contentOffset.y;
//    NSLog(@"%f",Y);
    if (Y>=-65 && Y<=0) {
        _searchBarRect.origin.y = 20 - (Y-(-65));
        _searchBar.frame = _searchBarRect;
        _tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0  );
    }else if(Y>0){
        _searchBar.frame = CGRectMake(0, 20-65, 414, 45);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else if(Y<-65){
        _searchBar.frame = CGRectMake(0, 20, 414, 45);
        _tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0  );
    }
    if (Y>=310) {
        if(!_hasPresentBottomViewcontroller){
            _hasPresentBottomViewcontroller = YES;
            WJFaXianBottomViewController *controller = [WJFaXianBottomViewController new];
            JYNavigationViewController *nav = [[JYNavigationViewController alloc]initWithRootViewController:controller];
            [self presentViewController:nav animated:NO completion:^{
                controller.faXianViewScorllToTop = ^{
                    [_tableView setContentOffset:CGPointMake(0, -65) animated:YES];
                   
                };
            }];
        }
    }
    if (Y==-65) {
        _hasPresentBottomViewcontroller = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    //利用kvc改状态栏背景色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor whiteColor];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    //利用kvc改状态栏背景色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}
@end
