//
//  WJPhotoBroserCollectionViewCell.h
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/8.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPhotoBroserCollectionViewCell : UICollectionViewCell
@property(weak,nonatomic)UIScrollView *scrollView;
@property(weak,nonatomic)UIImageView *imageView;
-(void)setUpImage:(NSString *)url index:(NSInteger)index;
@end
