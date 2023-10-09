//
//  WJFaXianTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/28.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaXianLunBoTableViewCell.h"

@interface CollecitonViewCell:UICollectionViewCell
@property(weak,nonatomic)UIImageView *imageView;
@end
@implementation CollecitonViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //lunbo图片
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:imageView];
        //头像
        [imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    }
    return self;
}
@end

@interface WJFaXianLunBoTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation WJFaXianLunBoTableViewCell
#define cellheight 110
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, cellheight);
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[CollecitonViewCell class] forCellWithReuseIdentifier:@"CollecitonViewCell"];
       _collectionView = collectionView;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
        [self.contentView addSubview:collectionView];
        //约束
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [collectionView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [collectionView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;

    }
    return self;
}
#pragma mark collctionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollecitonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollecitonViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"lunbo1"];
    return cell;
}
#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
