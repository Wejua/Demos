//
//  WJWoOneTableViewCell.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/24.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJWoOneTableViewCell : UITableViewCell
@property(weak,nonatomic)UIButton *touXiangBtn;
@property(weak,nonatomic)UIView *touXiangDetailView;
@property(weak,nonatomic)UILabel *touXiangDetailViewTitle;
@property(weak,nonatomic)UILabel *touXiangDetailViewJianJie;
@property(weak,nonatomic)UILabel *touXiangDetailViewJieShao;
@property(weak,nonatomic)UIImageView *huiYuanImgV;
@property(weak,nonatomic)UILabel *huiYuanLabel;
@property(weak,nonatomic)UIImageView *jianTouImgV;
@end

