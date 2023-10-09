//
//  FlexibleSeparatorSurroundingContentViewControllerView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "FlexibleSeparatorSurroundingContentView.h"

@implementation FlexibleSeparatorSurroundingContentView
{
    ASImageNode *_topImageNode;
    ASImageNode *_bottomImageNode;
    ASTextNode *_textNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        _topImageNode = [ASImageNode new];
        _topImageNode.image = [UIImage as_resizableRoundedImageWithCornerRadius:1.0 cornerColor:[UIColor blueColor] fillColor:[UIColor blueColor]];
        
        _textNode = [ASTextNode new];
        _textNode.attributedText = [[NSAttributedString alloc]initWithString:@"this is a long text node" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
        
        _bottomImageNode = [ASImageNode new];
        _bottomImageNode.image = [UIImage as_resizableRoundedImageWithCornerRadius:1.0 cornerColor:[UIColor blueColor] fillColor:[UIColor blueColor]];
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    _textNode.style.alignSelf = ASStackLayoutAlignSelfCenter;
    
//    ASStackLayoutSpec *verticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:20 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsStretch children:@[_topImageNode,_textNode,_bottomImageNode]];
    
    ASStackLayoutSpec *verticalSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    verticalSpec.direction = ASStackLayoutDirectionVertical;
    verticalSpec.spacing = 20;
    verticalSpec.justifyContent = ASStackLayoutJustifyContentCenter;
    verticalSpec.children = @[_topImageNode,_textNode,_bottomImageNode];
    return verticalSpec;
}
@end
