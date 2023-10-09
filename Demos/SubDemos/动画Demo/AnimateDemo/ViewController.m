//
//  ViewController.m
//  AnimateDemo
//
//  Created by 位杰周 on 16/2/1.
//  Copyright © 2016年 位杰周. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)void (^block)();

@property(nonatomic,weak)UIView *view1;
@property(nonatomic,weak)UIView *view2;
@property(nonatomic,weak)UIView *view3;
@property(nonatomic,weak)UIView *view4;
@property(nonatomic,weak)UIView *view5;
@property(nonatomic,weak)UIView *view6;
@property(nonatomic,weak)UIImageView *view7;
@property(nonatomic,weak)UIView *view8;
@property(nonatomic,weak)UIImageView *view9;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* recognizer1;
    recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnimation1)];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view1];
    self.view1 = view1;
    view1.backgroundColor = [UIColor redColor];
    [view1 addGestureRecognizer:recognizer1];
    self.index = 1;
    
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation2)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    [self.view addSubview:view2];
    self.view2 = view2;
    view2.backgroundColor = [UIColor blueColor];
    [view2 addGestureRecognizer:recognizer2];
    self.index = 2;
    
    UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation3)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:view3];
    self.view3 = view3;
    view3.backgroundColor = [UIColor orangeColor];
    [view3 addGestureRecognizer:recognizer3];
    self.index = 3;
    
    UITapGestureRecognizer *recognizer4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation4)];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:view4];
    self.view4 = view4;
    view4.backgroundColor = [UIColor greenColor];
    [view4 addGestureRecognizer:recognizer4];
    self.index = 4;
    
    UITapGestureRecognizer *recognizer5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation5)];
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:view5];
    self.view5 = view5;
    view5.backgroundColor = [UIColor grayColor];
    [view5 addGestureRecognizer:recognizer5];
    self.index = 5;
    
    UITapGestureRecognizer *recognizer6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation6)];
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    [self.view addSubview:view6];
    self.view6 = view6;
    view6.backgroundColor = [UIColor brownColor];
    [view6 addGestureRecognizer:recognizer6];
    self.index = 6;
    
    UITapGestureRecognizer *recognizer7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation7)];
    UIImageView *view7 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 400, 100, 100)];
    [self.view addSubview:view7];
    self.view7 = view7;
    [view7 addGestureRecognizer:recognizer7];
    view7.image = [UIImage imageNamed:@"o"];
    view7.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recognizer8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation8)];
    UIView *view8 = [[UIView alloc]initWithFrame:CGRectMake(200, 400, 100, 100)];
    [self.view addSubview:view8];
    self.view8 = view8;
    view8.backgroundColor = [UIColor blueColor];
    [view8 addGestureRecognizer:recognizer8];
    view8.alpha = 0.1;
    self.index = 8;
    
    UITapGestureRecognizer *recognizer9 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnimation9)];
    UIImageView *view9 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 500, 100, 100)];
    [self.view addSubview:view9];
    self.view9 = view9;
    view9.image = [UIImage imageNamed:@"o"];
    [view9 addGestureRecognizer:recognizer9];
    view9.userInteractionEnabled = YES;
}

-(void)tapAnimation1{
    //翻转动画
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:1];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向_imp	UITapRecognizer *	0x7f9461c5ce00	0x00007f9461c5ce00
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:self.view1 cache:YES];
    //动画结束
    [UIView commitAnimations];
}
-(void)tapAnimation2{
    //创建一个CGAffineTransform  transform对象
    CGAffineTransform  transform;
    //设置旋转度数
    transform = CGAffineTransformRotate(self.view2.transform,M_PI/3);
    //动画开始
    [UIView beginAnimations:@"rotate" context:nil ];
    //动画时常
    [UIView setAnimationDuration:1];
    //添加代理
    [UIView setAnimationDelegate:self];
    //获取transform的值
    [self.view2 setTransform:transform];
    //关闭动画  
    [UIView commitAnimations];
    
}
-(void)tapAnimation3{
    BOOL hasChange;
    
    CGAffineTransform transform;
    transform=CGAffineTransformInvert(self.view3.transform);
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    hasChange = !hasChange;
//    if (self.view3.frame.origin.x == 100 ) {
        self.view3.frame = CGRectMake(0, 200, 100, 100);
//    }else{
//        self.view3.frame = CGRectMake(100, 200, 100, 100);
//        [UIView beginAnimations:@"move" context:nil];
//    }
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"Invert" context:nil];
    [UIView setAnimationDuration:1];//动画时常
    [UIView setAnimationDelegate:self];
    [self.view3 setTransform:transform];//获取改变后的view的transform
    [UIView commitAnimations];//关闭动画
}
-(void)tapAnimation4{
    [UIView beginAnimations:@"curlUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//指定动画曲线类型，该枚举是默认的，线性的是匀速的
    //设置动画时常
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    //设置翻页的方向
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view4 cache:YES];
    //关闭动画
    [UIView commitAnimations];
}
-(void)tapAnimation5{
    CGAffineTransform  transform;
    transform = CGAffineTransformScale(self.view5.transform,1.5,1.5);
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [self.view5 setTransform:transform];
    [UIView commitAnimations];
}
-(void)tapAnimation6{
// 取反动画
//    CGAffineTransform transform;
//    transform=CGAffineTransformInvert(self.view6.transform);
//
//    [UIView beginAnimations:@"Invert" context:nil];
//    [UIView setAnimationDuration:2];//动画时常
//    [UIView setAnimationDelegate:self];
//    [self.view6 setTransform:transform];//获取改变后的view的transform
//    [UIView commitAnimations];//关闭动画
    
//    self.view6.transform = CGAffineTransformMakeScale(0, 0);
//    [UIView animateWithDuration:1.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
//        self.view6.transform = CGAffineTransformIdentity;
//    } completion:nil];
    
    /**
     *  relativeDuration  动画在什么时候开始
     *  relativeStartTime 动画所持续的时间
     */
    [UIView animateKeyframesWithDuration:6.f
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor redColor];
                                                                }];

                                  [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor yellowColor];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
                                                          relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                                                animations:^{
                                                                    self.view.backgroundColor = [UIColor greenColor];                                                                }];
                                  
                              }
                              completion:^(BOOL finished) {
                                  [self tapAnimation6];
                              }];
}

-(void)tapAnimation7{
//    void (^keyFrameBlock)() = ^(){
//        // 创建颜色数组
//        NSArray *arrayColors = @[[UIColor orangeColor],
//                                 [UIColor yellowColor],
//                                 [UIColor greenColor],
//                                 [UIColor blackColor],
//                                 [UIColor blueColor],
//                                 [UIColor purpleColor],
//                                 [UIColor redColor]];
//        NSUInteger colorCount = [arrayColors count];
//        // 循环添加关键帧
//        for (NSUInteger i = 0; i < colorCount; i++) {
//            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
//                                    relativeDuration:1.5 / (CGFloat)colorCount
//                                          animations:^{
//                                              [self.view7 setBackgroundColor:arrayColors[i]];
//                                          }];
//        }
//    };
//    [UIView animateKeyframesWithDuration:4.0
//                                   delay:0.0
//                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
//                              animations:keyFrameBlock
//                              completion:^(BOOL finished) {
//                              }];
    
    self.view7.image = [UIImage imageNamed:@"v"];
    CATransition *transition = [CATransition animation];
    transition.duration = 2.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view7.layer addAnimation:transition forKey:nil];
    
//    [self.view7.layer addAnimation:[self opacityForever_Animation:2] forKey:nil];
}
-(void)tapAnimation8{
    
    [UIView animateWithDuration:3 animations:^{
        self.view8.alpha = 1;
    }completion:^(BOOL finished) {
        self.view8.alpha = 0.1;
    }];
    
  
}
-(void)tapAnimation9{
    
    NSArray *myPoints = [NSArray arrayWithObjects:
                         [NSValue valueWithCGPoint:CGPointMake(0,500)],
                         [NSValue valueWithCGPoint:CGPointMake(0,400)],
                         [NSValue valueWithCGPoint:CGPointMake(0,300)],
                         [NSValue valueWithCGPoint:CGPointMake(0,200)],
                         [NSValue valueWithCGPoint:CGPointMake(0,100)],
                         [NSValue valueWithCGPoint:CGPointMake(0,0)],
                         [NSValue valueWithCGPoint:CGPointMake(100,0)],
                         [NSValue valueWithCGPoint:CGPointMake(200,0)],
                         [NSValue valueWithCGPoint:CGPointMake(300,0)],
                         [NSValue valueWithCGPoint:CGPointMake(300,100)],
                         [NSValue valueWithCGPoint:CGPointMake(300,200)],
                         [NSValue valueWithCGPoint:CGPointMake(300,300)],
                         [NSValue valueWithCGPoint:CGPointMake(300,400)],
                         [NSValue valueWithCGPoint:CGPointMake(300,500)],
                         [NSValue valueWithCGPoint:CGPointMake(200,500)],
                         [NSValue valueWithCGPoint:CGPointMake(150,550)],
                         nil];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 150, 550);
    for(NSValue *val in myPoints){
        CGPoint p = [val CGPointValue];
        CGPathAddLineToPoint(path, NULL, p.x, p.y);
    }
    
    [self.view9.layer addAnimation:[self keyframeAniamtion:path durTimes:5.0 Rep:1] forKey:nil];
    
}
//淡入
-(CABasicAnimation *)opacityForever_Animation:(float)time

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}
//路径
-(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes

{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}
//点移动
-(CABasicAnimation *)movepoint:(CGPoint )point

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}

@end
