//
//  ViewController.m
//  排序图
//
//  Created by 周位杰 on 2022/11/17.
//

#import "ViewController.h"
//#import <Charts/Charts-Swift.h>
#import "MenuView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) MenuView *menuView;
//@property (nonatomic, strong) BarChartView *chartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.menuView];
//    [self.view addSubview:self.chartView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(15);
    }];
//    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.menuView.mas_bottom).mas_offset(10);
//        make.left.right.mas_equalTo(self.menuView);
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-15);
//    }];
}

//- (BarChartView *)chartView {
//    if (!_chartView) {
//        _chartView = [[BarChartView alloc] init];
//        _chartView.backgroundColor = UIColor.redColor;
//    }
//    return _chartView;
//}

- (MenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MenuView alloc] init];
        _menuView.backgroundColor = UIColor.redColor;
    }
    return _menuView;
}

@end
