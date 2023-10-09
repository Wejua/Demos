//
//  ViewController.m
//  weijie.stock
//
//  Created by 周位杰 on 2021/12/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(100, 100, 100, 50);
}

- (void)request {
    NSString *gid = @"sh601009";
    NSString *string = [NSString stringWithFormat:@"http://web.juhe.cn:8080/finance/stock/hs?gid=%@&key=2aea47a3dd98cab97dec15e1e844cbb0", gid];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            if (res.statusCode == 200) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"%@",[dic description]);
            }
        }] resume];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton new];
        _button.backgroundColor = UIColor.grayColor;
        [_button setTitle:@"测试接口" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
