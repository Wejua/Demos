//
//  WJHaiMeiYouTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/23.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJHaiMeiYouTableViewCell.h"
#import "WJHaiMeiYouTongZhiView.h"
@interface WJHaiMeiYouTableViewCell()
@property(weak,nonatomic)UIView *view;
@end
@implementation WJHaiMeiYouTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        WJHaiMeiYouTongZhiView *view = [[WJHaiMeiYouTongZhiView alloc]init];
        _view = view;
        [self.contentView addSubview:view];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_view.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [_view.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}
@end
