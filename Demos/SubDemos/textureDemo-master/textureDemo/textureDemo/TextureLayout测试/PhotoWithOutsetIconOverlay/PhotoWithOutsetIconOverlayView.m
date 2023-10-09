//
//  PhotoWithOutsetIconOverlayView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "PhotoWithOutsetIconOverlayView.h"
#import "Utilities.h"

@implementation PhotoWithOutsetIconOverlayView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        _photoNode = [ASNetworkImageNode new];
        _photoNode.URL = [NSURL URLWithString:@"http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-photo.png"];
//        _photoNode.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        
        _iconNode = [ASNetworkImageNode new];
        _iconNode.URL = [NSURL URLWithString:@"http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-icon.png"];
        [_iconNode setImageModificationBlock:^UIImage * _Nullable(UIImage * _Nonnull image) {
            //处理图片
            return [image makeCircularImageWithSize:CGSizeMake(60, 60) withBorderWidth:10];
        }];
//        _iconNode.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    }
    return self;
}
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _iconNode.style.preferredSize = CGSizeMake(40, 40);
    _iconNode.style.layoutPosition = CGPointMake(150, 0);
    
    _photoNode.style.preferredSize = CGSizeMake(150, 150);
    _photoNode.style.layoutPosition = CGPointMake(40 / 2.0, 40 / 2.0);
    
    ASAbsoluteLayoutSpec *absoluteSpec = [ASAbsoluteLayoutSpec absoluteLayoutSpecWithChildren:@[_photoNode, _iconNode]];
    
    // ASAbsoluteLayoutSpec's .sizing property recreates the behavior of ASDK Layout API 1.0's "ASStaticLayoutSpec"
    absoluteSpec.sizing = ASAbsoluteLayoutSpecSizingSizeToFit;
    
    return absoluteSpec;
}
@end
