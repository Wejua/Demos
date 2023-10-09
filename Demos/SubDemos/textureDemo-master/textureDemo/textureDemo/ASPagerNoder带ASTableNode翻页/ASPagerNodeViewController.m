//
//  ASPagerNodeTableNodeViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/29.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ASPagerNodeViewController.h"

#import "EmbeddedTableNodeCellNode.h"

@interface ASPagerNodeViewController ()<ASPagerDelegate,ASPagerDataSource>
@end
@implementation ASPagerNodeViewController
{
    ASPagerNode *_pager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pager  = [[ASPagerNode alloc]init];
//    pager.delegate = self;
    _pager.dataSource = self;
    _pager.frame = self.view.bounds;
    [self.view addSubnode:_pager];
}
#pragma mark - datasource
- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode{
    return 20;
}
- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index{
    //注意这句话不能放在block里面
    CGSize size = CGSizeMake(pagerNode.bounds.size.width, 100);
    return ^{
        ASCellNode *node = [[EmbeddedTableNodeCellNode alloc]initWithElementSize:size];
        return node ;
    };
}
@end
