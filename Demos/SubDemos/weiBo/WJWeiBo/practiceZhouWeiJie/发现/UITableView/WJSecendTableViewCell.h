//
//  WJSecendTableViewCell.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/28.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSegmentView.h"

@interface WJSecendTableViewCell : UITableViewCell
@property(weak,nonatomic)UITableView *tableView;

@property(weak,nonatomic) WJSegmentView*segmentView;
@property(nonatomic)NSInteger preOffsetX;
@property(nonatomic)bool hasDraged;
@end
