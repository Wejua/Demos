//
//  WJFaXianCollectionViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/5.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaXianCollectionViewCell.h"
#import "WJFaXianShiPinTableViewCell.h"
#import "WJFaXianTouTiaoTableViewCell.h"

@interface WJFaXianCollectionViewCell()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation WJFaXianCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加tableView
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height-64) style:UITableViewStyleGrouped];
        [self.contentView addSubview:tableView];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView = tableView;
        tableView.delegate = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource = self;
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = 0;
        tableView.backgroundColor = ViewBackgoundColor;
        [tableView registerClass:[WJFaXianShiPinTableViewCell class] forCellReuseIdentifier:@"WJFaXianShiPinTableViewCell"];
        [tableView registerClass:[WJFaXianTouTiaoTableViewCell class] forCellReuseIdentifier:@"WJFaXianTouTiaoTableViewCell"];
        tableView.userInteractionEnabled = NO;
        
        [tableView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [tableView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [tableView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [tableView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    
    }
    return self;
}
#pragma datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WJFaXianShiPinTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"WJFaXianShiPinTableViewCell" forIndexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WJFaXianShiPinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJFaXianShiPinTableViewCell"];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    UIView *view = (UIView *)cell.bottomView;
    CGFloat height = CGRectGetMaxY(view.frame);
    CGFloat separatorHeight = 1.0;
    return height +separatorHeight;
}

@end
