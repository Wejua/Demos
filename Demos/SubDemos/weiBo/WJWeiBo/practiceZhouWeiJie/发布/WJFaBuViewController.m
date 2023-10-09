//
//  WJFaBuViewController.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/25.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaBuViewController.h"
#import "WJFaBuCollectionViewCell.h"

@interface WJFaBuChaCha:UIButton
@end
@implementation WJFaBuChaCha
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.widthAnchor constraintEqualToConstant:17].active = YES;
    [self.imageView.heightAnchor constraintEqualToConstant:17].active = YES;
}
@end
@interface WJFaBuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(weak,nonatomic)UICollectionView  *collectionV;

@property(copy,nonatomic)NSArray *titles;
@property(copy,nonatomic)NSArray *images;
@property(nonatomic)bool isdisplay;
@property(weak,nonatomic)UIButton *quXiaoBtn;
@end
@implementation WJFaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //模糊效果
    self.view.backgroundColor = [UIColor clearColor];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    
    //collectionView放button
    _images = @[@[@"wenzi",@"hongbao",@"paise",@"tiwen",@"xiangce",@"qiandao",@"zhibo",@"dianping"],@[@"huati",@"shagnpin",@"guangyingxiu",@"miaopai",@"haoyouquan",@"kilakila",@"yinyue",@"toutiaowenzang"]];
    _titles = @[@[@"文字",@"红包",@"拍摄",@"提问",@"相册",@"签到",@"直播",@"点评"],@[@"话题",@"商品",@"光影秀" ,@"秒拍",@"好友圈",@"KilaKila",@"音乐",@"头条文章"]];
#define heightS 200
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat spaceCell  = ([UIScreen mainScreen].bounds.size.width - 4*60)/5;
    layout.sectionInset = UIEdgeInsetsMake(spaceCell, spaceCell, [UIScreen mainScreen].bounds.size.height/2-heightS, spaceCell);
    layout.minimumLineSpacing = spaceCell;
    layout.itemSize = CGSizeMake(60, 85);
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREENSIZE.height/2-spaceCell, SCREENSIZE.width, [UIScreen mainScreen].bounds.size.height/2+spaceCell) collectionViewLayout:layout];
    [self.view addSubview:collectionV];
    collectionV.pagingEnabled = YES;
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.backgroundColor = [UIColor clearColor];
    _collectionV = collectionV;
    collectionV.dataSource = self;
    collectionV.delegate = self;
    [collectionV registerClass:[WJFaBuCollectionViewCell class] forCellWithReuseIdentifier:@"WJFaBuCollectionViewCell"];
    
    //添加取消按钮
    WJFaBuChaCha *quXiaoBtn = [[WJFaBuChaCha alloc]init];
    _quXiaoBtn = quXiaoBtn;
    [quXiaoBtn setImage:[UIImage imageNamed:@"chacha"] forState:UIControlStateNormal];
    [quXiaoBtn addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    quXiaoBtn.contentMode = UIViewContentModeCenter;
    float width = 49;
    float height = 49;
    quXiaoBtn.frame = CGRectMake(self.view.bounds.size.width/2-width/2, self.view.bounds.size.height -height, width,height);
    [self.view addSubview:quXiaoBtn];
    
    //分割线
    UIImageView *fenGeXian = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREENSIZE.height-height-0.5, SCREENSIZE.width, 0.5)];
    fenGeXian.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self.view addSubview:fenGeXian];
}
//消失动画
-(void)quxiao:(WJFaBuChaCha *)button{
#define durationMacro 0.5
#define delayMacro 0.02
#define dampingMacro 0.65
#define velocityMacro 0.1
//    [self dismissViewControllerAnimated:YES completion:nil];
    NSArray *cellArray = _collectionV.visibleCells;
    NSArray *indexPaths = _collectionV.indexPathsForVisibleItems;
    WJFaBuCollectionViewCell *cell;
    NSIndexPath *indexPath;
    for ( int i = 0;i<cellArray.count ;i++ ) {
        cell = cellArray[i];
        indexPath = indexPaths[i];
        NSInteger row = cellArray.count-1-indexPath.row;
        [UIView animateWithDuration:durationMacro delay:delayMacro*row usingSpringWithDamping:dampingMacro initialSpringVelocity:velocityMacro options:UIViewAnimationOptionLayoutSubviews animations:^{
            if(i==0){
                button.transform = CGAffineTransformRotate(button.transform, -M_PI_4);
            }
            cell.transform = CGAffineTransformTranslate(cell.transform, 0, [UIScreen mainScreen].bounds.size.height/2);
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}
#pragma mark collctionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WJFaBuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFaBuCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.section][indexPath.row]];
    cell.titleLabel.text = _titles[indexPath.section][indexPath.row];
    return cell;
}
#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//即将显示时使用动画加载
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && _isdisplay == NO){
        cell.transform  =  CGAffineTransformTranslate(cell.transform, 0, [UIScreen mainScreen].bounds.size.height/2);
        [UIView animateWithDuration:durationMacro delay:delayMacro*indexPath.row usingSpringWithDamping:dampingMacro initialSpringVelocity:velocityMacro options:UIViewAnimationOptionLayoutSubviews animations:^{
            if(indexPath.row == 0){
                //旋转button
                _quXiaoBtn.transform = CGAffineTransformRotate(_quXiaoBtn.transform, M_PI_4);
            }
            cell.transform = CGAffineTransformTranslate(cell.transform, 0, -[UIScreen mainScreen].bounds.size.height/2);
        } completion:nil];
        if(indexPath.row == 7)
            _isdisplay = YES;
    }
}




@end
