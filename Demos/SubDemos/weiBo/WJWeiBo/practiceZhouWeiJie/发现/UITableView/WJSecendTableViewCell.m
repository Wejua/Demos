//
//  WJSecendTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/28.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJSecendTableViewCell.h"
#import "WJFaXianCollectionViewCell.h"
@interface WJSecendTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation WJSecendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,SCREENSIZE.height-64);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;///CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-300)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:collectionV];
        collectionV.pagingEnabled = YES;
        collectionV.dataSource = self;
        collectionV.delegate = self;
        [collectionV registerClass:[WJFaXianCollectionViewCell class] forCellWithReuseIdentifier:@"WJFaXianCollectionViewCell"];
//        collectionV.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
        collectionV.backgroundColor = ViewBackgoundColor;
        collectionV.translatesAutoresizingMaskIntoConstraints = NO;
        _segmentView.detailView = collectionV;
        
        [collectionV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [collectionV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [collectionV.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [collectionV.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    }
    return self;
}
#pragma mark collctionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJFaXianCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFaXianCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
    return cell;
}
#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//scrollview代理切换
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if ( x > SCREENSIZE.width*3 || x < 0) return;
    if(_segmentView)
    _segmentView.refreshLine(x);
}
@end
