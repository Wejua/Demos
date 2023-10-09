//
//  CornerLayoutExampleView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "CornerLayoutExampleView.h"
#import "Utilities.h"

@implementation CornerLayoutExampleView
{
    ASImageNode *imageNode1;
    ASImageNode *iconImage1;
    
    ASImageNode *imageNode2;
    ASImageNode *iconImage2;
    ASTextNode *badgeTextNode;
    
    ASNetworkImageNode *imageNode3;
    ASNetworkImageNode *iconImage3;
}
static CGFloat const kSampleAvatarSize = 100;
static CGFloat const kSampleIconSize = 26;
static CGFloat const kSampleBadgeCornerRadius = 12;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        
        UIImage *avatarImage = [self avatarImageWithSize:CGSizeMake(kSampleAvatarSize, kSampleAvatarSize)];
        UIImage *cornerImage = [self cornerImageWithSize:CGSizeMake(kSampleIconSize, kSampleIconSize)];
        
        imageNode1 = [ASImageNode new];
        imageNode1.image = avatarImage;
        iconImage1 = [ASImageNode new];
        iconImage1.image = cornerImage;
        
        imageNode2 = [ASImageNode new];
        imageNode2.image = avatarImage;
        badgeTextNode = [ASTextNode new];
        badgeTextNode.attributedText = [[NSAttributedString alloc]initWithString:@" 999+ "attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        iconImage2 = [ASImageNode new];
        iconImage2.image = [UIImage as_resizableRoundedImageWithCornerRadius:kSampleBadgeCornerRadius cornerColor:UIColor.clearColor fillColor:UIColor.redColor];
        
        imageNode3 = [ASNetworkImageNode new];
        imageNode3.URL = [NSURL URLWithString:@"http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-photo.png"];
        iconImage3 = [ASNetworkImageNode new];
        iconImage3.URL = [NSURL URLWithString:@"http://texturegroup.org/static/images/layout-examples-photo-with-outset-icon-overlay-icon.png"];
    }
    return self;
}
-(UIImage *)avatarImageWithSize:(CGSize)size{
    return  [UIImage imageWithSize:size fillColor:UIColor.lightGrayColor shapeBlock:^UIBezierPath *{
        CGRect rect = (CGRect){CGPointZero,size};
        return [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:MIN(size.width, size.height)/20];
    }];
}
-(UIImage *)cornerImageWithSize:(CGSize)size{
    return [UIImage imageWithSize:size fillColor:UIColor.redColor shapeBlock:^UIBezierPath *{
        CGRect rect = (CGRect){CGPointZero,size};
        return [UIBezierPath bezierPathWithOvalInRect:rect];
    }];
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASCornerLayoutSpec *cornerSpec1 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:imageNode1 corner:iconImage1 location:ASCornerLayoutLocationTopRight];
    cornerSpec1.offset = CGPointMake(-3, 3);
    
    ASBackgroundLayoutSpec *backGroundSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:badgeTextNode background:iconImage2];
    ASCornerLayoutSpec *cornerSpec2 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:imageNode2 corner:backGroundSpec location:ASCornerLayoutLocationTopRight];
    
    ASCornerLayoutSpec *cornerSpec3 = [ASCornerLayoutSpec cornerLayoutSpecWithChild:imageNode3 corner:iconImage3 location:ASCornerLayoutLocationTopRight];
    imageNode3.style.preferredSize = CGSizeMake(kSampleAvatarSize, kSampleAvatarSize);
    iconImage3.style.preferredSize = CGSizeMake(kSampleIconSize, kSampleIconSize);
    
    return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:40 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[cornerSpec1,cornerSpec2,cornerSpec3]];
}
@end
