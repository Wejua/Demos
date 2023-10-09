//
//  EmbeddedTableNodeCellNode.h
//  textureDemo
//
//  Created by jieyi lu on 2018/4/2.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//


@interface EmbeddedTableNodeCellNode : ASCellNode
@property (nonatomic) NSInteger pageNumber;
-(instancetype)initWithElementSize:(CGSize)size;
@end
