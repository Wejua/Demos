//
//  WJViewMode.h
//  textureDemo
//
//  Created by jieyi lu on 2018/3/26.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJViewModel : NSObject
+(instancetype)sharedModel;
//UICollectionViewTestViewController的数据
@property (nonatomic,strong)NSMutableArray<NSMutableArray<NSString*>*> *data;
//ViewController的数据
@property (nonatomic,strong)NSMutableArray<NSString *> *demos;
//TextureLayoutTestViewController数据
@property (nonatomic,strong)NSMutableArray<NSString *> *ASLayoutDemos;
@end
