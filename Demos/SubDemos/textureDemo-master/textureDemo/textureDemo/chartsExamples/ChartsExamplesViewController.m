//
//  ChartsExamplesViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/16.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ChartsExamplesViewController.h"

@interface ChartsExamplesViewController ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic,strong)ASTableNode *tableNode;
@property (nonatomic,strong)NSArray<NSArray<NSDictionary*> *> *data;
@end

@implementation ChartsExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"chartsExamplesVCName" ofType:@"plist"];
    _data = [NSArray arrayWithContentsOfFile:path];
    
    _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    [self.view addSubnode:_tableNode];
    _tableNode.frame = self.view.bounds;
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
}

#pragma ASTableNodeDatasource
-(NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return _data.count;
}
-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return _data[section].count;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASTextCellNode *node = [[ASTextCellNode alloc]init];
        node.text = _data[indexPath.section][indexPath.row][@"Text"];
        node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        return node;
    };
}
#pragma mark - ASTableNodeDelegate
-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = _data[indexPath.section][indexPath.row][@"VCName"];
    [self.navigationController pushViewController:[NSClassFromString(vcName) new] animated:YES];
}

@end
