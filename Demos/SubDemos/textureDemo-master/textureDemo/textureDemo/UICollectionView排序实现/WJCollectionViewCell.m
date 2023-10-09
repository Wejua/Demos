//
//  WJCollectionViewCell.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/26.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "WJCollectionViewCell.h"
@interface WJCollectionViewCell()
@property (nonatomic,weak)UILabel *label;
@end
@implementation WJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        _label = label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:label];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(void)setUPData:(NSIndexPath *)indexPath{
    _label.text = [WJViewModel sharedModel].data[indexPath.section][indexPath.row];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [_label.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [_label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [_label.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
}
@end
