//
//  ViewController.m
//  AnimationWithInteraction
//
//  Created by 周位杰 on 2021/1/8.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()
@property (nonatomic, strong) TestView *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.animationView];
    self.animationView.frame = CGRectMake(100, 100, 200, 200);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animation];
}


- (void)animation {
    [UIView animateKeyframesWithDuration:15 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            self.animationView.frame = CGRectMake(300, 100, 200, 200);
    } completion:nil];
}


- (void)stopAnimation {
    NSLog(@"%s", _cmd);
}


- (TestView *)animationView {
    if (!_animationView) {
        _animationView = [[TestView alloc] init];
        _animationView.backgroundColor = UIColor.redColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopAnimation)];
        [_animationView addGestureRecognizer:tap];
    }
    return _animationView;
}
@end
