//
//  Utilities.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "Utilities.h"

@implementation UIImage (Additions)

- (UIImage *)makeCircularImageWithSize:(CGSize)size withBorderWidth:(CGFloat)width
{
    // make a CGRect with the image's size
    CGRect circleRect = (CGRect) {CGPointZero, size};
    
    // begin the image context since we're not in a drawRect:
    UIGraphicsBeginImageContextWithOptions(circleRect.size, NO, 0);
    
    // create a UIBezierPath circle
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:circleRect.size.width/2];
    
    // clip to the circle
    [circle addClip];
    
    [[UIColor whiteColor] set];
    [circle fill];
    
    // draw the image in the circleRect *AFTER* the context is clipped
    [self drawInRect:circleRect];
    
    // create a border (for white background pictures)
    if (width > 0) {
        circle.lineWidth = width;
        [[UIColor whiteColor] set];
        [circle stroke];
    }
    
    // get an image from the image context
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // end the image context since we're not in a drawRect:
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

+ (UIImage *)imageWithSize:(CGSize)size fillColor:(UIColor *)fillColor shapeBlock:(UIBezierPath *(^)(void))shapeBlock
{
    UIGraphicsBeginImageContext(size);
    [fillColor setFill];
    
    UIBezierPath *path = shapeBlock();
    [path addClip];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

