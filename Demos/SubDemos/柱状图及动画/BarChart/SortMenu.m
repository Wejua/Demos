//
//  SortButton.m
//  BarChart
//
//  Created by 周位杰 on 2022/11/19.
//

#import "SortMenu.h"
#import <Masonry/Masonry.h>

@implementation SortMenu
{
    CGFloat _textFontSize;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.listStack];
        [self addSubview:self.textL];
    }
    return self;
}

- (void)updateConstraints {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortait = UIInterfaceOrientationIsPortrait(orientation);
    _textFontSize = isPortait ? 10 : 18;
    
    _textL.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:_textFontSize];
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:_textFontSize];
    _ascButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:_textFontSize];
    _descButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:_textFontSize];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self);
    }];
    [self.textL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(isPortait ? 3 : 6);
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(isPortait ? 50 : 100);
        make.height.mas_equalTo(isPortait ? 20 : 40);
    }];
    [self.listStack mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.textL);
    }];
    
    [super updateConstraints];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint nPoint = [self convertPoint:point toView:self.listStack];
    if (CGRectContainsPoint(self.listStack.bounds, nPoint)) {
        return true;
    } else {
        return [super pointInside:point withEvent:event];
    }
}

- (void)sortMenuClick {
    if (self.sortMenuDidClickBlock) {
        self.sortMenuDidClickBlock();
    }
    if (self.listStack.isHidden == YES) {
        [self clickAnimation];
    };
}

- (void)clickAnimation {
    if (self.listStack.isHidden) {
        [self.listStack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textL.mas_bottom);
            make.left.right.mas_equalTo(self.textL);
        }];
        self.listStack.alpha = 1.0;
    } else {
        [self.listStack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.textL);
        }];
        self.listStack.alpha = 0.0;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.listStack.hidden = !self.listStack.isHidden;
    }];
}

- (void)ascButtonClick {
    if (self.sortMenuDidClickBlock) {
        self.sortMenuDidClickBlock();
    }
    self.textL.text = @"从小到大";
    [self clickAnimation];
}

- (void)descButtonClick {
    if (self.sortMenuDidClickBlock) {
        self.sortMenuDidClickBlock();
    }
    self.textL.text = @"从大到小";
    [self clickAnimation];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)textL {
    if (!_textL) {
        _textL = [[UILabel alloc] init];
        _textL.textColor = [UIColor blackColor];
        _textL.text = @"从小到大";
        _textL.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _textL.layer.borderWidth = 1;
        _textL.layer.cornerRadius = 3;
        _textL.layer.masksToBounds = YES;
        _textL.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortMenuClick)];
        [_textL addGestureRecognizer:tap];
        _textL.userInteractionEnabled = true;
        _textL.backgroundColor = UIColor.whiteColor;
    }
    return _textL;
}
- (UIStackView *)listStack {
    if(!_listStack) {
        _listStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.ascButton, self.descButton]];
        _listStack.alignment = UIStackViewAlignmentCenter;
        _listStack.axis = UILayoutConstraintAxisVertical;
        _listStack.hidden = YES;
    }
    return _listStack;
}

- (UIButton *)ascButton {
    if (!_ascButton) {
        _ascButton = [[UIButton alloc] init];
        [_ascButton setTitle:@"从小到大" forState:UIControlStateNormal];
        [_ascButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ascButton addTarget:self action:@selector(ascButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ascButton;
}

- (UIButton *)descButton {
    if (!_descButton) {
        _descButton = [[UIButton alloc] init];
        [_descButton setTitle:@"从大到小" forState:UIControlStateNormal];
        [_descButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_descButton addTarget:self action:@selector(descButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _descButton;
}

@end
