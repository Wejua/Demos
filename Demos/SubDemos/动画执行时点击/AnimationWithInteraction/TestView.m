//
//  TestView.m
//  AnimationWithInteraction
//
//  Created by 周位杰 on 2021/1/8.
//

#import "TestView.h"

@implementation TestView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL b = [super pointInside:point withEvent:event];
    CGPoint newPoint = [self convertPoint:point toView:self.superview];
    BOOL newB = CGRectContainsPoint(self.layer.presentationLayer.frame, newPoint);
    return newB;
}



@end
