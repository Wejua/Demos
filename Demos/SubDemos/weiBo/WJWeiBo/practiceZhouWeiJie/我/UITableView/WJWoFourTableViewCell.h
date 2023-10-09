//
//  WJWoFourTableViewCell.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJWoFourTableViewCell : UITableViewCell
@property(weak,nonatomic)UILabel *jingChangFW;
@property(weak,nonatomic)UILabel *detail;
@property(copy,nonatomic)NSMutableArray *imgArray;
@property(copy,nonatomic)NSArray *imgNameArray;
@property(weak,nonatomic)UILabel *chaKanQB;
@end
