//
//  ASStackLayoutDemoView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ASStackLayoutDemoView.h"

@implementation ASStackLayoutDemoView
{
    ASTextNode *_textNodeLeftTop;
    ASTextNode *_textNodeLeftBottom;
    ASTextNode *_textNodeRightMiddle;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.automaticallyManagesSubnodes = YES;
        _textNodeLeftTop = [ASTextNode new];
        _textNodeLeftTop.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        _textNodeLeftTop.attributedText = [[NSAttributedString alloc]initWithString:@"名字点点滴滴" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor greenColor]}];
        
        _textNodeLeftBottom = [ASTextNode new];
        _textNodeLeftBottom.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        _textNodeLeftBottom.attributedText = [[NSAttributedString alloc]initWithString:@"地址嘎嘎大概大概" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blueColor]}];
        
        _textNodeRightMiddle = [ASTextNode new];
        _textNodeRightMiddle.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        _textNodeRightMiddle.attributedText = [[NSAttributedString alloc]initWithString:@"时间" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{\
    ASStackLayoutSpec *verticalStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    verticalStack.style.flexShrink = 1.0;//收缩
    verticalStack.style.flexGrow = 1.0;//伸展
    if (_textNodeLeftBottom.attributedText) {
        verticalStack.children = @[_textNodeLeftTop,_textNodeLeftBottom];
    }else{
        verticalStack.children = @[_textNodeLeftTop];
    }
    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:40 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[verticalStack,_textNodeRightMiddle]];
    ASInsetLayoutSpec *insetLayoutSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10) child:horizontalStack];
    return insetLayoutSpec;
}
@end
