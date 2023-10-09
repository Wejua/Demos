//
//  JYWoViewController.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/1/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "JYWoViewController.h"
#import "WJWoOneTableViewCell.h"
#import "WJWoTwoTableViewCell.h"
#import "WJWoThreeTableViewCell.h"
#import "WJWoFourTableViewCell.h"
#import "WJWoFiveTableViewCell.h"
#import "WJWoSixTableViewCell.h"
#import "WJWoSevenTableViewCell.h"
#import "WJFaBuViewController.h"

@interface JYWoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UIVisualEffectView *effectView;
@property(copy,nonatomic)NSArray *reuseID;
@end

@implementation JYWoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ViewBackgoundColor;
    //左边添加好友
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendsClick)];
    //title
    self.navigationItem.title = @"我";
    //右边设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置"style:UIBarButtonItemStylePlain target:self action:@selector(sheZhiClick)];
    [self.navigationItem.rightBarButtonItem setTitlePositionAdjustment:UIOffsetMake(10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setTitlePositionAdjustment:UIOffsetMake(-10, 0) forBarMetrics:UIBarMetricsDefault];
    
    //添加tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREENSIZE.height-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    _tableView = tableView;
//    tableView.estimatedRowHeight = 1;
//    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = 0;
    tableView.backgroundColor = ViewBackgoundColor;
    
    [tableView registerClass:[WJWoOneTableViewCell class] forCellReuseIdentifier:@"WJWoOneTableViewCell"];
    [tableView registerClass:[WJWoTwoTableViewCell class] forCellReuseIdentifier:@"WJWoTwoTableViewCell"];
    [tableView registerClass:[WJWoThreeTableViewCell class] forCellReuseIdentifier:@"WJWoThreeTableViewCell"];
    [tableView registerClass:[WJWoFourTableViewCell class] forCellReuseIdentifier:@"WJWoFourTableViewCell"];
    [tableView registerClass:[WJWoFiveTableViewCell class] forCellReuseIdentifier:@"WJWoFiveTableViewCell"];
    [tableView registerClass:[WJWoSixTableViewCell class] forCellReuseIdentifier:@"WJWoSixTableViewCell"];
    [tableView registerClass:[WJWoSevenTableViewCell class] forCellReuseIdentifier:@"WJWoSevenTableViewCell"];
    _reuseID = @[@"WJWoOneTableViewCell",@"WJWoTwoTableViewCell",@"WJWoThreeTableViewCell",@"WJWoFourTableViewCell",@"WJWoFiveTableViewCell",@"WJWoSixTableViewCell",@"WJWoSevenTableViewCell"];
 
}
-(void)addFriendsClick{
    NSLog(@"%s",__func__);
}
-(void)sheZhiClick{
    NSLog(@"%s",__func__);
    [_effectView removeFromSuperview];
}
#pragma datasource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section==0 || section==2 || section==3 )? 0.01 : 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 0;//去掉了经常访问的微博
            break;
        case 3:
            return 0;//去掉红包
            break;
        default:
            return 2;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                WJWoOneTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoOneTableViewCell" forIndexPath:indexPath];
                return cell;
            }else{
                WJWoTwoTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoTwoTableViewCell" forIndexPath:indexPath];
                return cell;
            }
            break;
        case 1:{
            WJWoThreeTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoThreeTableViewCell" forIndexPath:indexPath];
            return cell;}
            break;
        case 2:{
            WJWoFourTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoFourTableViewCell" forIndexPath:indexPath];
            return cell;}
            break;
        case 3:{
            WJWoFiveTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoFiveTableViewCell" forIndexPath:indexPath];
            return cell;}
            break;
        default:
            if (indexPath.row == 0) {
                WJWoSixTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoSixTableViewCell" forIndexPath:indexPath];
                return cell;
            }else{
                WJWoSevenTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJWoSevenTableViewCell" forIndexPath:indexPath];
                return cell;
            }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                return 86;
            }else{
                return 55;
            }
            break;
        case 1:
            return 160;
            break;
        case 2:
            return 186;
            break;
        case 3:
            return 243;
            break;
        default:
            return 47;
            break;
    }
}
@end
