//
//  PhotoWithInsetTextOverlayView.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "PhotoWithInsetTextOverlayView.h"

@implementation PhotoWithInsetTextOverlayView
{
    ASNetworkImageNode *_imageNode;
    ASTextNode *_textNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        _imageNode = [ASNetworkImageNode new];
//        _imageNode.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        _imageNode.URL = [NSURL URLWithString:@"http://texturegroup.org/static/images/layout-examples-photo-with-inset-text-overlay-photo.png"];
        _imageNode.willDisplayNodeContentWithRenderingContext = ^(CGContextRef  _Nonnull context, id  _Nullable drawParameters) {
            CGRect bounds = CGContextGetClipBoundingBox(context);
            [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:10]addClip];
            
        };
        
        _textNode = [ASTextNode new];
        _textNode.maximumNumberOfLines = 2;
        _textNode.truncationMode = NSLineBreakByTruncatingTail;
        _textNode.truncationAttributedText = [[NSAttributedString alloc]initWithString:@"..." attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:[UIColor purpleColor]}];
        _textNode.attributedText = [[NSAttributedString alloc]initWithString:@"family fall hikes.family fall hikes" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
//    _imageNode.style.preferredSize = CGSizeMake(150, 150);
    CGFloat photoDimension = constrainedSize.max.width/4;
    _imageNode.style.preferredSize = CGSizeMake(photoDimension, photoDimension);
    UIEdgeInsets insets = UIEdgeInsetsMake(INFINITY, 12, 12,12);
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:_textNode];
    return [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:insetSpec];
}
@end
