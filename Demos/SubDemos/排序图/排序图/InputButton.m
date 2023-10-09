//
//  InputButton.m
//  排序图
//
//  Created by 周位杰 on 2022/11/18.
//

#import "InputButton.h"

@interface InputButton()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *field;
@end

@implementation InputButton
- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _label;
}

- (UITextField *)field {
    if (!_field) {
        _field = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _field;
}

@end
