//
//  WJCollectionViewSupplementaryCellCollectionViewCell.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/26.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "WJCollectionViewSupplementaryCellCollectionViewCell.h"
@interface WJCollectionViewSupplementaryCellCollectionViewCell()
@property (nonatomic,weak)UILabel *label;
@end
@implementation WJCollectionViewSupplementaryCellCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        _label = label;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(void)setUPData:(NSIndexPath*)indexPath{
    _label.text = [WJViewModel sharedModel].data[indexPath.section][indexPath.row];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_label.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_label.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
}
@end
