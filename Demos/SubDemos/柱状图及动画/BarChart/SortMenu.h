//
//  SortButton.h
//  BarChart
//
//  Created by 周位杰 on 2022/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortMenu : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *textL;
@property (nonatomic, strong) UIStackView *listStack;
@property (nonatomic, strong) UIButton *descButton;
@property (nonatomic, strong) UIButton *ascButton;
@property (nonatomic, copy) void (^sortMenuDidClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
