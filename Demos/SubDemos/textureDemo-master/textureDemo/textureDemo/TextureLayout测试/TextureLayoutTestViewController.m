//
//  TextureLayoutTestViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "TextureLayoutTestViewController.h"
#import "ASStackLayoutSpecViewController.h"

@interface TextureLayoutTestViewController ()<ASTableDataSource,ASTableDelegate>
@property (nonatomic,strong)ASTableNode *tableNode;
@end

@implementation TextureLayoutTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    [self.view addSubnode:_tableNode];
    _tableNode.frame = self.view.bounds;
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
}
#pragma ASTableNodeDatasource
-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return [WJViewModel sharedModel].ASLayoutDemos.count;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASTextCellNode *node = [[ASTextCellNode alloc]init];
        node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        node.text = [WJViewModel sharedModel].ASLayoutDemos[indexPath.row];
        return node;
    };
}
#pragma mark - ASTableNodeDelegate
-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *classString = [WJViewModel sharedModel].ASLayoutDemos[indexPath.row];
    ASViewController *VC = [NSClassFromString(classString) new];
    VC.title = classString;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
