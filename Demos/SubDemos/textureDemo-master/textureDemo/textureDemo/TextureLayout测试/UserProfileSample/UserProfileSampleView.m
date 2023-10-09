//
//  UserProfileSample.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "UserProfileSampleView.h"
#import "Utilities.h"

@interface UserProfileSampleView()
@property (nonatomic, strong) ASImageNode *badgeNode;
@property (nonatomic, strong) ASImageNode *avatarNode;
@property (nonatomic, strong) ASTextNode *usernameNode;
@property (nonatomic, strong) ASTextNode *subtitleNode;
@property (nonatomic, assign) CGFloat photoSizeValue;
@property (nonatomic, assign) CGFloat iconSizeValue;
@end
@implementation UserProfileSampleView
{
    ASImageNode *_avatarImage;
    ASImageNode *_badgeImage;
    ASTextNode *_userNameText;
    ASTextNode *_subTitleText;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        _avatarImage = [ASImageNode new];
        CGSize size = CGSizeMake(44, 44);
        _avatarImage.image = [UIImage imageWithSize:size fillColor:UIColor.lightGrayColor shapeBlock:^UIBezierPath *{
            return [UIBezierPath bezierPathWithOvalInRect:(CGRect){CGPointZero,size}];
        }];

        _badgeImage = [ASImageNode new];
        CGSize badgeSize = CGSizeMake(15, 15);
        _badgeImage.image = [UIImage imageWithSize:badgeSize fillColor:[UIColor redColor] shapeBlock:^UIBezierPath *{
            return [UIBezierPath bezierPathWithOvalInRect:(CGRect){CGPointZero,badgeSize}];
        }];

        _userNameText = [ASTextNode new];
        _userNameText.attributedText = [[NSAttributedString alloc]initWithString:@"userName" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
        _userNameText.maximumNumberOfLines = 1;

        _subTitleText = [ASTextNode new];
        _subTitleText.attributedText = [[NSAttributedString alloc]initWithString:@"this is a long long subTitle , with a long long trail,this is a long long subTitle,with a long long trail,this is a long long subTitle,with a long long trail" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}];
        _subTitleText.maximumNumberOfLines = 1;
        _subTitleText.truncationMode = NSLineBreakByTruncatingTail;
        
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASCornerLayoutSpec *avartarAndBadgeSpec = [ASCornerLayoutSpec cornerLayoutSpecWithChild:_avatarImage corner:_badgeImage location:ASCornerLayoutLocationBottomRight];
    avartarAndBadgeSpec.offset = CGPointMake(-6, -6);
    ASStackLayoutSpec *titleAddSubtitleSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceAround alignItems:ASStackLayoutAlignItemsStretch children:@[_userNameText,_subTitleText]];
    ASStackLayoutSpec *leftAndRightSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter children:@[avartarAndBadgeSpec,titleAddSubtitleSpec]];

    NSArray *elems = @[_userNameText, _subTitleText, titleAddSubtitleSpec, leftAndRightSpec];
    for (id <ASLayoutElement> elem in elems) {
        elem.style.flexShrink = 1;
    }
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(120, 20, INFINITY, 20) child:leftAndRightSpec];
}
@end
