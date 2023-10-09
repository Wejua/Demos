//
//  MenuView.m
//  排序图
//
//  Created by 周位杰 on 2022/11/18.
//

#import "MenusView.h"
#import <Masonry/Masonry.h>

@implementation MenusView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.minM];
        [self addSubview:self.maxM];
        [self addSubview:self.numM];
        [self addSubview:self.sortM];
        [self addSubview:self.makeB];
    }
    return self;
}

- (void)updateConstraints {
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication.statusBarOrientation);
    CGFloat menuMargin = isPortrait ? 10 : 18;
    CGFloat fontSize = isPortrait ? 10 : 18;
    _makeB.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];

    [self.minM mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(self);
    }];
    [self.maxM mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minM.mas_right).mas_offset(menuMargin);
        make.centerY.mas_equalTo(self.minM.mas_centerY);
    }];
    [self.numM mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxM.mas_right).mas_offset(menuMargin);
        make.centerY.mas_equalTo(self.minM.mas_centerY);
    }];
    [self.sortM mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numM.mas_right).mas_offset(menuMargin);
        make.centerY.mas_equalTo(self.minM.mas_centerY);
    }];
    [self.makeB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.sortM.mas_right).offset(menuMargin);
        make.width.mas_equalTo(isPortrait ? 50 : 100);
    }];
    
    [super updateConstraints];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint nPoint = [self convertPoint:point toView:self.sortM.listStack];
    if (CGRectContainsPoint(self.sortM.listStack.bounds, nPoint)) {
        return true;
    } else {
        return [super pointInside:point withEvent:event];
    }
}

- (void)makeButtonClick {
    [self resignTextFields];
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSString *minText = self.minM.field.text;
    NSString *maxText = self.maxM.field.text;
    NSString *numText = self.numM.field.text;
    
    int minV = 0;
    int maxV = 0;
    int countV = 0;
    BOOL shouldShowAlert = false;
    BOOL isAscending = [self.sortM.textL.text isEqualToString:@"从大到小"] ? NO : YES;
    
    if ([pred evaluateWithObject:minText] && [minText intValue] >= 1 && [minText intValue] <= 100) {
        minV = [minText intValue];
    } else {
        shouldShowAlert = shouldShowAlert | YES;
    }
    if ([pred evaluateWithObject:maxText] && [maxText intValue] >= 1 && [maxText intValue] <= 100) {
        maxV = [maxText intValue];
    } else {
        shouldShowAlert = shouldShowAlert | YES;
    }
    if ([pred evaluateWithObject:numText] && [numText intValue] >= 1 && [numText intValue] <= 10) {
        countV = [numText intValue];
    } else {
        shouldShowAlert = shouldShowAlert | YES;
    }
    
    if (self.predicateDidCompleteBlock) {
        self.predicateDidCompleteBlock(minV, maxV, countV, isAscending, shouldShowAlert);
    }
}

- (void)resignTextFields {
    [self.minM.field resignFirstResponder];
    [self.maxM.field resignFirstResponder];
    [self.numM.field resignFirstResponder];
}

- (inputMenu *)minM {
    if (!_minM) {
        _minM = [[inputMenu alloc] init];
        _minM.label.text = @"最小值:";
    }
    return _minM;
}

- (inputMenu *)maxM {
    if (!_maxM) {
        _maxM = [[inputMenu alloc] init];
        _maxM.label.text = @"最大值:";
    }
    return _maxM;
}
- (inputMenu *)numM {
    if (!_numM) {
        _numM = [[inputMenu alloc] init];
        _numM.label.text = @"数量:";
    }
    return _numM;
}
- (SortMenu *)sortM {
    if (!_sortM) {
        _sortM = [[SortMenu alloc] init];
        _sortM.titleLabel.text = @"排序:";
        __weak typeof(self) weakSelf = self;
        _sortM.sortMenuDidClickBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf resignTextFields];
        };
    }
    return _sortM;
}
- (UIButton *)makeB {
    if(!_makeB) {
        _makeB = [UIButton new];
        [_makeB setTitle:@"生成" forState:UIControlStateNormal];
        _makeB.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:163.0/255.0 blue:251/255.0 alpha:1];
        _makeB.layer.masksToBounds = YES;
        _makeB.layer.cornerRadius = 4.0;
        [_makeB addTarget:self action:@selector(makeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeB;
}
@end
