//
//  InputButton.m
//  排序图
//
//  Created by 周位杰 on 2022/11/18.
//

#import "inputMenu.h"
#import <Masonry/Masonry.h>

@implementation inputMenu
{
    CGFloat _textFontSize;
    CGFloat _textMargin;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.field];
    }
    return self;
}

- (void)updateConstraints {
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    BOOL isPortait = UIInterfaceOrientationIsPortrait(orientation);
    
    _textFontSize = isPortait ? 10.0 : 18.0;
    _textMargin = isPortait ? 3 : 6;
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:_textFontSize];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
    NSDictionary *dic = @{
        NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:_textFontSize],
        NSForegroundColorAttributeName:[UIColor lightGrayColor],
    };
    [text addAttributes:dic range:NSMakeRange(0, text.length)];
    self.field.attributedPlaceholder = text;
    _field.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:_textFontSize];
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self);
    }];
    [self.field mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label.mas_right).mas_offset(isPortait ? 3 : 6);
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(isPortait ? 40 : 80);
        make.height.mas_equalTo(isPortait ? 20 : 40);
    }];
    
    [super updateConstraints];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UITextField *)field {
    if (!_field) {
        _field = [[UITextField alloc] init];
        _field.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _field.layer.borderWidth = 1;
        _field.layer.cornerRadius = 3;
        _field.layer.masksToBounds = YES;
        _field.textAlignment = NSTextAlignmentCenter;
    }
    return _field;
}

@end
