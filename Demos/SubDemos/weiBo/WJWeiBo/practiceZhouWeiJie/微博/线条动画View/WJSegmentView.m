//
//  WJSegment.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/6.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJSegmentView.h"
@interface WJSegmentButton:UIControl
@property(nonatomic)bool hasArrow;
@property(nonatomic)bool shouldShowArrow;
@property(weak,nonatomic)UIImageView *imageView;
@property(weak,nonatomic)UILabel *titleLabel;
@end
@implementation WJSegmentButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView  = imgv;
        [self addSubview: imgv];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel  = titleLabel;
        [self addSubview: titleLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_hasArrow && _shouldShowArrow) {
        self.imageView.hidden = NO;
    }else{
        self.imageView.hidden = YES;
    }
    
    [_titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [_titleLabel.rightAnchor constraintEqualToAnchor:_imageView.leftAnchor constant:-2].active = YES;
#define imageViewWidth 10
#define imageViewHeight 5
    [_imageView.centerYAnchor constraintEqualToAnchor:_titleLabel.centerYAnchor].active = YES;
    [_imageView.widthAnchor constraintEqualToConstant:imageViewWidth].active = YES;
    [_imageView.heightAnchor constraintEqualToConstant:imageViewHeight].active = YES;
    
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    return YES;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
}
-(void)cancelTrackingWithEvent:(UIEvent *)event{
    
}

//#define imageWidth 10
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat imageW = imageWidth;
//    CGFloat imageH = 5;
//    CGFloat imageX = contentRect.size.width-imageW;
//    CGFloat imageY = contentRect.size.height/2-imageH/2;
//    return CGRectMake(imageX, imageY, imageW, imageH);
//}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    CGFloat titleW = contentRect.size.width-imageWidth-2;
//    CGFloat titleH = contentRect.size.height;
//    CGFloat titleX = 0;
//    CGFloat titleY = 0;
//    return CGRectMake(titleX, titleY, titleW, titleH);
//}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    if (!_isInitializeButton) {
//        self.imageView.hidden = YES;
//    }
//}
@end

@interface WJSegmentView()
@property(nonatomic)CGFloat titleSpace;
@property(nonatomic)CGFloat buttonWidth;

@property(weak,nonatomic)UIImageView *indicator;

@property(weak,nonatomic)WJSegmentButton *currentButton;
@property(weak,nonatomic)WJSegmentButton *nextButton;

@property(nonatomic)CGRect middleFrame;
@property(nonatomic)CGRect middleFrameRight;

@end
@implementation WJSegmentView

-(instancetype)initWithTitles:(NSArray <NSString *> *)titles hasArrow:(BOOL)hasArrow frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _buttons = [NSMutableArray array];
        //添加button
        for (int i = 0 ; i<titles.count ;i++) {
            //关注
            CGFloat titleSpace = (frame.size.width-47*titles.count)/(titles.count+1);
            _titleSpace = titleSpace;
            CGFloat buttonWidth = 47;
            _buttonWidth = buttonWidth;
            WJSegmentButton *button = [[WJSegmentButton alloc]initWithFrame:CGRectMake(titleSpace+(buttonWidth+titleSpace)*i, 0, buttonWidth, CGRectGetHeight(frame))];
            [_buttons addObject:button];
            //箭头图片
            button.imageView.image = [UIImage imageNamed:@"titleViewSanJiaoXing"];
            button.hasArrow = hasArrow;
            button.shouldShowArrow = NO;
            //title
            button.titleLabel.text = titles[i];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            button.titleLabel.textColor = [UIColor lightGrayColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [button addGestureRecognizer:tap];
            [self addSubview:button];
        }
        
        //初始化按钮
        [self makeButtonChange:_buttons[0]];
        
        //指示器
#define indicatorHeight 4
        WJSegmentButton *button = _buttons[0];
        CGRect titleRectOfSegmentView = button.frame;
        UIImageView *indicator = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleRectOfSegmentView), CGRectGetMaxY(titleRectOfSegmentView)-10, CGRectGetWidth(titleRectOfSegmentView)-imageViewWidth-2, indicatorHeight)];
        [self addSubview:indicator];
        _indicator = indicator;
        indicator.layer.cornerRadius = 2;
        indicator.backgroundColor = [UIColor colorWithRed:251/255.0 green:129/255.0 blue:35/255.0 alpha:1.0];
        __weak typeof (self) weakSelf  = self;
        _refreshLine = ^(CGFloat offsetX){
            //滑动过快会有bug，所以每次翻页后更新currentButton
//            if (fmodf(offsetX, SCREENSIZE.width) != 0) {
                WJSegmentButton *currentButton = weakSelf.buttons[(int)((offsetX+SCREENSIZE.width/2)/SCREENSIZE.width)];
                [weakSelf makeButtonChange:currentButton];
//            }
            NSInteger index = [weakSelf.buttons indexOfObject:weakSelf.currentButton];
            //偏移量
            CGFloat offset = (offsetX-index*SCREENSIZE.width)/SCREENSIZE.width*(weakSelf.buttonWidth+weakSelf.titleSpace)*2;
//                NSLog(@"offset:%f,offsetX:%f",offset,offsetX);
            
            weakSelf.middleFrame = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame), CGRectGetMaxY(weakSelf.currentButton.frame)-10, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2+(weakSelf.buttonWidth+weakSelf.titleSpace), indicatorHeight);
            weakSelf.middleFrameRight = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame)-(weakSelf.buttonWidth+weakSelf.titleSpace), CGRectGetMaxY(weakSelf.currentButton.frame)-10, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2+(weakSelf.buttonWidth+weakSelf.titleSpace), indicatorHeight);
            if (offsetX >= index*SCREENSIZE.width && offsetX < (index+0.5)*SCREENSIZE.width) {
                //右滑动，但是没有到一半
                weakSelf.indicator.frame = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame), weakSelf.middleFrame.origin.y, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2+offset, indicatorHeight);
            }else if(offsetX >= (index+0.5)*SCREENSIZE.width && offsetX <= (index+1)*SCREENSIZE.width){
                //右滑动，超过了一半
                weakSelf.indicator.frame = CGRectMake(weakSelf.middleFrame.origin.x + (offset-(weakSelf.buttonWidth+weakSelf.titleSpace)), weakSelf.middleFrame.origin.y, weakSelf.middleFrame.size.width-(offset-(weakSelf.buttonWidth+weakSelf.titleSpace)), indicatorHeight);
                if (offsetX == (index+1)*SCREENSIZE.width) {
                    [weakSelf makeButtonChange:weakSelf.buttons[index+1]];
                    weakSelf.indicator.frame = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame), weakSelf.middleFrame.origin.y, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2, indicatorHeight);
                }
                
            }else if(offsetX > (index-0.5)*SCREENSIZE.width && offsetX < index*SCREENSIZE.width){
                //左滑动，没到一半
                weakSelf.indicator.frame = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame)+offset, weakSelf.middleFrame.origin.y, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2-offset, indicatorHeight);
            }else if(offsetX >= (index-1)*SCREENSIZE.width && offsetX < (index-0.5)*SCREENSIZE.width){
                //左滑动到了一半
                weakSelf.indicator.frame = CGRectMake(weakSelf.middleFrameRight.origin.x , weakSelf.middleFrameRight.origin.y, weakSelf.middleFrameRight.size.width+(offset+(weakSelf.buttonWidth+weakSelf.titleSpace)), indicatorHeight);
                if (offsetX == (index-1)*SCREENSIZE.width) {
                    [weakSelf makeButtonChange:weakSelf.buttons[index-1]];
                    weakSelf.indicator.frame = CGRectMake(CGRectGetMinX(weakSelf.currentButton.frame), weakSelf.middleFrame.origin.y, CGRectGetWidth(weakSelf.currentButton.frame)-imageViewWidth-2, indicatorHeight);
                }
            }
        };
    }
    return self;
}
-(void)makeButtonChange:(WJSegmentButton *)button{
    _currentButton.shouldShowArrow = NO;
    [_currentButton setNeedsLayout];
    _currentButton.titleLabel.textColor = [UIColor lightGrayColor];
    _currentButton.titleLabel.font = [UIFont systemFontOfSize:17];
    _currentButton = button;
    button.shouldShowArrow = YES;
    [button setNeedsLayout];
    button.titleLabel.textColor = [UIColor blackColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
}
//直接点击button
-(void)click:(WJSegmentButton *)button{
//    if(button.hasArrow && button.shouldShowArrow){
//        button.imageView.transform = CGAffineTransformRotate(button.imageView.transform, M_PI);
//        //弹出下拉菜单
//        NSLog(@"弹出下拉菜单");
//
//    }else{
//        [self makeButtonChange:button];
//        //移动指示器
//        CGRect currentFrame = self.indicator.frame;
//        self.indicator.frame = CGRectMake(CGRectGetMinX(_currentButton.frame), currentFrame.origin.y, CGRectGetWidth(_currentButton.frame)-imageViewWidth-2, currentFrame.size.height);
//        //切换detail View
//        if(_detailView){
////            _detailView.splitTitleViewDidClick([_buttons indexOfObject:_currentButton]);
//        }
//    }
}
@end
