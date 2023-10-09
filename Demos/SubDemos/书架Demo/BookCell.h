//
//  BookCell.h
//  书架Demo
//
//  Created by tommy on 15/11/30.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJImgVforDeleteBook.h"

@protocol BookCellDelegate <NSObject>

-(void)didClickBtn;

@end
@interface BookCell : UICollectionViewCell
@property (nonatomic,weak) WJImgVforDeleteBook *removeImgV;
@property(nonatomic,weak)id delegate;
@end

