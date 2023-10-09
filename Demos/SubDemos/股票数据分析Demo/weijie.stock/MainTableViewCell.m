//
//  MainTableViewCell.m
//  weijie.stock
//
//  Created by 周位杰 on 2021/12/9.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *increPer;
@end
@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

#pragma lazy properties
- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
    }
    return _name;
}

- (UILabel *)increPer {
    if (!_increPer) {
        _increPer = [UILabel new];
        
    }
    return _increPer;
}

@end
