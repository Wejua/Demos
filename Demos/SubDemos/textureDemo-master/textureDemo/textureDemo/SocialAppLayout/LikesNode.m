//
//  LikesNode.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/9.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "LikesNode.h"
#import "TextStyles.h"

@implementation LikesNode
{
    ASImageNode *_likeImage;
    ASTextNode *_likeCount;
}
-(instancetype)initWithLikesCount:(NSInteger)count{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        _likeImage = [ASImageNode new];
        _likeImage.image = [UIImage imageNamed:@"icon_like.png"];
        
        _likeCount = [ASTextNode new];
        _likeCount.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld", (long)count] attributes:[TextStyles cellControlStyle]];
        self.hitTestSlop = UIEdgeInsetsMake(-20, -20, -20, -20);
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{
    self.backgroundColor = [UIColor grayColor];
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *spec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_likeImage,_likeCount]];
    spec.style.minWidth = ASDimensionMakeWithPoints(60);
    return spec;
}
@end
