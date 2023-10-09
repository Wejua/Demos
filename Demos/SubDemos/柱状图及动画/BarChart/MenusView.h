//
//  MenuView.h
//  排序图
//
//  Created by 周位杰 on 2022/11/18.
//

#import <UIKit/UIKit.h>
#import "inputMenu.h"
#import "SortMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenusView : UIView
@property(nonatomic, strong) inputMenu *minM;
@property(nonatomic, strong) inputMenu *maxM;
@property(nonatomic, strong) inputMenu *numM;
@property(nonatomic, strong) SortMenu *sortM;
@property(nonatomic, strong) UIButton *makeB;
@property(nonatomic, copy) void (^predicateDidCompleteBlock)(int minV, int maxV, int coutV, BOOL isAscending, BOOL shouldShowAlert);
@end

NS_ASSUME_NONNULL_END
