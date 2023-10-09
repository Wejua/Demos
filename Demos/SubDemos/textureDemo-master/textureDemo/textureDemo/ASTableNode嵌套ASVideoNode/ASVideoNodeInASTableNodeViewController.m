//
//  ASVideoNodeInASTableNodeViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/4.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ASVideoNodeInASTableNodeViewController.h"

@interface ASVideoNodeInASTableNodeViewController ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic,strong)ASTableNode *tableNode;
@property (nonatomic,strong)ASDisplayNode *node1;
@end

@implementation ASVideoNodeInASTableNodeViewController
- (instancetype)init
{
    ASDisplayNode *displayNode = [ASDisplayNode new];
    self = [super initWithNode:displayNode];
    if (self) {
        _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        [self.node addSubnode:_tableNode];
        _tableNode.frame = [UIScreen mainScreen].bounds;
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        
        _node1 = [ASDisplayNode new];
        [self.node addSubnode:_node1];
//            _node1.frame = CGRectMake(0, 100, 100, 100);
        _node1.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        __weak __typeof(self) weakself = self;
        _node1.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            weakself.node1.style.preferredSize = CGSizeMake(100, 100);
            weakself.node1.style.layoutPosition = CGPointMake(100, 200);
            return [ASAbsoluteLayoutSpec absoluteLayoutSpecWithChildren:@[weakself.node1]];
        };
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
  
}
#pragma ASTableNodeDatasource
-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ASCellNode *node = [[ASCellNode alloc]init];
        node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
        return node;
    };
}
#pragma mark - ASTableNodeDelegate
-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
