//
//  ViewController.m
//  BarChart
//
//  Created by 周位杰 on 2022/11/18.
//

#import "ViewController.h"
#import <Charts/Charts-Swift.h>
#import <Masonry/Masonry.h>
#import "MenusView.h"

@interface ViewController () <ChartViewDelegate>
@property (nonatomic, strong) MenusView *menusV;
@property (nonatomic, strong) BarChartView *chartView;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int dataCount;
@property (nonatomic, assign) BOOL isAscending;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.maxValue = 100;
//    self.minValue = 1;
//    self.dataCount = 10;
    
    self.isAscending = true;
    
    [self.view addSubview:self.chartView];
    [self.view addSubview:self.menusV];
    
//    [self setData];
}

- (void)updateViewConstraints {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isPortait = UIInterfaceOrientationIsPortrait(orientation);
    
    [self.menusV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(25);
    }];
    [self.chartView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menusV.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight).mas_offset(-15);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-15);
    }];
    
    [super updateViewConstraints];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.menusV setNeedsUpdateConstraints];
    [self.menusV.minM setNeedsUpdateConstraints];
    [self.menusV.maxM setNeedsUpdateConstraints];
    [self.menusV.numM setNeedsUpdateConstraints];
    [self.menusV.sortM setNeedsUpdateConstraints];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入错误" message:@"最小值和最大值为1-100以内的整数, 数量为1-10以内的整数" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setData {
    NSMutableArray *randomVals = [NSMutableArray array];
    for (int i = 0; i < self.dataCount; i++) {
//        if (i == 2) {
//            [randomVals addObject:@(100)];
//        } else {
            int randomV = self.minValue + arc4random_uniform(self.maxValue - self.minValue + 1);
            [randomVals addObject:@(randomV)];
//        }
    }
    NSArray *sortedVals = [randomVals sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int val1 = [obj1 intValue];
        int val2 = [obj2 intValue];
        if (val1 > val2) {
            return self.isAscending ? NSOrderedDescending : NSOrderedAscending;
        } else if (val1 < val2) {
            return self.isAscending ? NSOrderedAscending : NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    NSMutableArray *yVals = [NSMutableArray array];
    [sortedVals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:idx+1 y:[obj doubleValue]];
        [yVals addObject:entry];
    }];
    
    BarChartDataSet *set1 = nil;
    if (self.chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)self.chartView.data.dataSets[0];
        [set1 replaceEntries: yVals];
        [self.chartView.data notifyDataChanged];
        [self.chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithEntries:yVals label:@""];
        [set1 setColors:@[[ChartColorTemplates colorFromString:@"#44a3fb"]]];
        
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.f]];
        [data setValueTextColor:UIColor.blackColor];
        
        data.barWidth = 0.6f;
        
        _chartView.data = data;
        
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.allowsFloats = false;
        formatter.maximumFractionDigits = 0;
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    }
    
    [self.chartView animateWithYAxisDuration:3];
}

- (BarChartView *)chartView {
    if (!_chartView) {
        _chartView = [[BarChartView alloc] init];
        _chartView.delegate = self;
        _chartView.chartDescription.enabled = NO;
        _chartView.drawGridBackgroundEnabled = NO;
        _chartView.dragEnabled = YES;
        [_chartView setScaleEnabled:NO];
        _chartView.pinchZoomEnabled = NO;
        _chartView.extraTopOffset = 20;
//        _chartView.backgroundColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.3 alpha:0.4];
        
        _chartView.noDataText = @"请在上方输入框中输入数据！";
        
        _chartView.drawBarShadowEnabled = NO;
        _chartView.legend.form = ChartLegendFormNone;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        _chartView.rightAxis.enabled = NO;
        xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.f];
        xAxis.labelTextColor = UIColor.blackColor;
        xAxis.axisLineColor = UIColor.blackColor;
        xAxis.axisLineWidth = 1;
        xAxis.drawGridLinesEnabled = NO;
        
        NSNumberFormatter *xAxisFormatter = [[NSNumberFormatter alloc] init];
        xAxisFormatter.allowsFloats = false;
        xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:xAxisFormatter];
        
        xAxis.granularity = 1.0;
        xAxis.labelCount = 10;
        xAxis.axisMaximum = 10.9;
        xAxis.axisMinimum = 0.3;
        
//        xAxis.spaceMax = 0.9;
//        xAxis.spaceMin = 0.5;
//        xAxis.axisMinLabels = 10;
        
        NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
        leftAxisFormatter.allowsFloats = false;
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.f];
        leftAxis.labelTextColor = [UIColor lightGrayColor];
        leftAxis.axisLineColor = UIColor.blackColor;
        leftAxis.axisLineWidth = 1;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.gridColor = [UIColor lightGrayColor];
        
        leftAxis.granularity = 10;
        leftAxis.labelCount = 10;
        leftAxis.axisMinimum = 0;
        leftAxis.axisMaximum = 109;
        
//        leftAxis.axisMinLabels = 10;
//        leftAxis.spaceTop = 0.9;
        
    }
    return _chartView;
}

- (MenusView *)menusV {
    if (!_menusV) {
        _menusV = [[MenusView alloc] init];
//        _menusV.backgroundColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.3 alpha:0.4];
        __weak typeof(self) weakS = self;
        _menusV.predicateDidCompleteBlock = ^(int minV, int maxV, int coutV, BOOL isAscending, BOOL shouldShowAlert) {
            if (shouldShowAlert) {
                [weakS showAlert];
            } else {
                weakS.minValue = minV;
                weakS.maxValue = maxV;
                weakS.dataCount = coutV;
                weakS.isAscending = isAscending;
                [weakS setData];
            }
        };
    }
    return _menusV;
}

@end

