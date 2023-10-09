//
//  EmbeddedTableNodeCellNode.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/2.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "EmbeddedTableNodeCellNode.h"
#import "ItemNode.h"

@interface EmbeddedTableNodeCellNode()<ASTableDelegate,ASTableDataSource>
@end
@implementation EmbeddedTableNodeCellNode

{
    ASTableNode *_ASTableNode;
    CGSize _size;
}
-(instancetype)initWithElementSize:(CGSize)size{
    if (!(self = [super init]))
        return nil;
    _size = size;
    _ASTableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    _ASTableNode.delegate = self;
    _ASTableNode.dataSource = self;
    [self addSubnode:_ASTableNode];
    return self;
}
#pragma mark - ASTableNodeDelegate
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ^{
        ItemNode *node = [[ItemNode alloc]initWithString:[NSString stringWithFormat:@"index:%lu",indexPath.row]];
        node.style.preferredSize = _size;
        return node;
    };
}
- (void)layout
{
    [super layout];
    _ASTableNode.frame = self.bounds;
}
@end
