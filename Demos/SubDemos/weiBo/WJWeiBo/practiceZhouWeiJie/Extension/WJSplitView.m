//
//  WJSplitView.m
//  BuDeJieWJ
//
//  Created by WJMac on 2018/2/2.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJSplitView.h"

@interface WJCollctionViewCell:UICollectionViewCell
@end
@implementation WJCollctionViewCell
@end

@interface WJSplitView()<UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate>
@property(weak,nonatomic)UICollectionViewFlowLayout *layout;
//@property(nonatomic)BOOL isTitleBarButtonSetDetailToScroll;
@end
@implementation WJSplitView
{
    bool isTitleBarButtonSetDetailToScroll;
}

-(void)setDelegate:(id<WJJingHuaControllerViewDelegate>)delegate{
//    _detailView.delegate = delegate;
//    _titleBar.delegate = delegate;
    _delegate = delegate;
}
-(instancetype)init{
    self = [super init];
    if(self){
        _previousIdex = 0;
        _alignment = WJSplitViewAlignmentVertical;
        _titles = [NSMutableArray arrayWithObjects:@"关注",@"热门", nil];
        //添加titleView
        UIScrollView *titleScrollView = [[UIScrollView alloc]init];
        [self addSubview:titleScrollView];
        _titleBar = titleScrollView;
        titleScrollView.canCancelContentTouches = NO;
        _titleBar.delegate = self;
        //添加collectionView
        //layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _layout = layout;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
#define titleBarHeight 40
#define buttonW 80
        _titleBar.frame = CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width,titleBarHeight);
        _titleButtonArray = [NSMutableArray array];
        for (int i = 0, x=0; i<_titles.count; i++,x+=buttonW) {
            UIButton *button = [[UIButton alloc]init];
            [_titleBar addSubview:button];
            [_titleButtonArray addObject:button];
            [button setTitle:_titles[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            if(i == 0){
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.frame = CGRectMake(x, 0, buttonW, titleBarHeight);

            [button addTarget:self action:@selector(buttonOfTitleBarClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            titleScrollView.contentSize = CGSizeMake(buttonW*_titles.count, titleBarHeight);
            titleScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
            titleScrollView.showsVerticalScrollIndicator = NO;
            titleScrollView.showsHorizontalScrollIndicator = NO;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + titleBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-titleBarHeight) collectionViewLayout:layout];
        _detailView = collectionView;
        _detailView.delegate = self;
        [self addSubview:collectionView];
        layout.itemSize = collectionView.frame.size;
        collectionView.pagingEnabled = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        //dataSource
#define cellID @"cellID"
        _detailView.dataSource = self;
        [_detailView registerClass:[WJCollctionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return self;
}
-(void)layoutSubviews{
}
-(void)buttonOfTitleBarClick:(UIButton *)button{
    NSString *title = button.titleLabel.text;
    int index = (int)[_titles indexOfObject:title];
    if(_previousIdex != index){
        //现在的title改为黑色
        UIButton *btn = _titleButtonArray[index];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //原来的button颜色改为白色
        btn = _titleButtonArray[_previousIdex];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [_titleBar scrollRectToVisible:CGRectMake(index * buttonW - screenSize.width/2 + buttonW/2, 0,screenSize.width, titleBarHeight) animated:YES];
        isTitleBarButtonSetDetailToScroll = YES;
        [_detailView scrollRectToVisible:CGRectMake(index * screenSize.width, 0, screenSize.width, _detailView.frame.size.height) animated:NO];
        isTitleBarButtonSetDetailToScroll = NO;
        _previousIdex = index;
    }
}
#pragma dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%200+20)/255.0 green:(arc4random()%200+20)/255.0 blue:(arc4random()%200+20)/255.0 alpha:1.0];
    
    return cell;
}
#pragma delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(CGRectContainsRect(_detailView.frame, scrollView.frame)){
        //detailView
        if(!isTitleBarButtonSetDetailToScroll){
            int index = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
            if(_previousIdex != index){
                //现在的title改为黑色
                UIButton *button = _titleButtonArray[index];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                //原来的button颜色改为白色
                button = _titleButtonArray[_previousIdex];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                CGSize screenSize = [UIScreen mainScreen].bounds.size;
                [_titleBar scrollRectToVisible:CGRectMake(index * buttonW - screenSize.width/2 + buttonW/2, 0,screenSize.width, titleBarHeight) animated:YES];
                _previousIdex = index;
            }
        }
    }
}
@end
