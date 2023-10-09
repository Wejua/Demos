//
//  CommentsNode.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/9.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "CommentsNode.h"
#import "TextStyles.h"

@implementation CommentsNode
{
    ASImageNode *_commentsImage;
    ASTextNode *_commentsCount;
}
-(instancetype)initWithCommentsCount:(NSInteger)count{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        _commentsImage = [ASImageNode new];
        _commentsImage.image = [UIImage imageNamed:@"icon_comment.png"];
        
        _commentsCount = [ASTextNode new];
        _commentsCount.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",(long)count] attributes:[TextStyles cellControlStyle]];
        
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_commentsImage,_commentsCount]];
    spec.style.minWidth = ASDimensionMakeWithPoints(60);
    return spec;
}
@end
