//
//  WJFaBubuttonsTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/28.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaBubuttonsTableViewCell.h"

@interface WJFaBuButtonCollectionViewCell : UICollectionViewCell
@property(weak,nonatomic)UIImageView *imageView;
@property(weak,nonatomic)UILabel *titleLabel;
@end
@implementation WJFaBuButtonCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView  = imgv;
        [self addSubview: imgv];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel  = titleLabel;
        [self addSubview: titleLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    
    [self.titleLabel sizeToFit];
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor].active = YES;
    
}
@end


@interface WJFaBubuttonsTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(copy,nonatomic)NSArray *images;
@property(copy,nonatomic)NSArray *titles;
@end
@implementation WJFaBubuttonsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(30, 50);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = ([UIScreen mainScreen].bounds.size.width-30*5-30*2)/4;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width
        UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:collectionV];
        collectionV.contentInset = UIEdgeInsetsMake(20, 30, 20, 30);
        collectionV.scrollEnabled = NO;
        collectionV.dataSource = self;
        collectionV.delegate = self;
        [collectionV registerClass:[WJFaBuButtonCollectionViewCell class] forCellWithReuseIdentifier:@"WJFaBuButtonCollectionViewCell"];
        collectionV.backgroundColor = [UIColor whiteColor];
        //约束
        collectionV.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [collectionV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [collectionV.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [collectionV.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    
        _images = @[@"zhaoren",@"beijing",@"youxi",@"zhibofaxian",@"dianying",@"youwuzhi",@"saishi",@"caijing",@"ranghongbaofei",@"gengduo1"];
        _titles = @[@"找人",@"北京",@"游戏",@"直播",@"电影",@"尤物志",@"赛事",@"财经",@"让红包飞",@"更多"];
    
    }
    return self;
}

#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJFaBuButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFaBuButtonCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    cell.titleLabel.text = _titles[indexPath.row];
    return cell;
}
@end
