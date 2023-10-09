//
//  WJCollectionViewFlowLayout.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/16.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJCollectionViewFlowLayout.h"

@implementation WJCollectionViewFlowLayout
//cell左对齐,一个cell时
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    if(answer.count == 1){
        UICollectionViewLayoutAttributes *attributes = answer[0];
        CGRect frame = attributes.frame;
        frame.origin.x = 0;
        attributes.frame = frame;
    }
    return answer;
}
@end
