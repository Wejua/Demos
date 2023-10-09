//
//  BookCell.m
//  书架Demo
//
//  Created by tommy on 15/11/30.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "BookCell.h"
#import "Masonry.h"

@interface BookCell()
@end
@implementation BookCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加删除按钮
        WJImgVforDeleteBook *removeImgV = [[WJImgVforDeleteBook alloc]initWithImage:[UIImage imageNamed:@"book_bt-delete"]];
        removeImgV.userInteractionEnabled = YES;
        [self.contentView addSubview:removeImgV];
        self.removeImgV = removeImgV;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapBtn)];
        [removeImgV addGestureRecognizer:tap];
        
        //设置frame
        CGSize btnS = self.removeImgV.image.size;
        self.removeImgV.frame = CGRectMake(self.bounds.size.width-btnS.width/2, 0-btnS.width/2, btnS.width, btnS.height);
    }
    return self;
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = CGRectMake(0, -20, self.bounds.size.width+20, self.bounds.size.height+20);
    return CGRectContainsPoint(rect, point);
}
-(void)TapBtn{
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(didClickBtn)]) {
//        [self.removeImgV becomeFirstResponder];
//        NSLog(@"%@",self.removeImgV.nextResponder);
        [self.delegate didClickBtn];
    }
}


@end
