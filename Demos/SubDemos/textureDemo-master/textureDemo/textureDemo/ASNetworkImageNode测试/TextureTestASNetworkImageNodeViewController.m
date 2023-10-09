//
//  TextureTestASNetworkImageNodeViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/3/28.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "TextureTestASNetworkImageNodeViewController.h"

@interface TextureTestASNetworkImageNodeViewController ()<ASNetworkImageNodeDelegate>
@end

@implementation TextureTestASNetworkImageNodeViewController
#warning 注意要
//- (instancetype)init
//{
//    ASDisplayNode *displayNode = [[ASDisplayNode alloc]init];
//    self = [super initWithNode:displayNode];
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self textureTestASNetworkImageNode];
}
-(void)viewWillDisappear:(BOOL)animated{
    [WJActivityView dismiss];
}
-(void)textureTestASNetworkImageNode{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc]init];
    [self.view addSubnode:imageNode];
    imageNode.delegate = self;
    imageNode.frame = self.view.bounds;
    imageNode.contentMode = UIViewContentModeScaleAspectFit;
    imageNode.URL = [NSURL URLWithString:@"https://i.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif"];
    imageNode.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}
#pragma mark - ASNetworkImageNodeDelegate
//前两个不调用
-(void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image{
    [WJActivityView dismiss];
}
- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image info:(ASNetworkImageLoadInfo *)info{
    [WJActivityView dismiss];
}
-(void)imageNodeDidStartFetchingData:(ASNetworkImageNode *)imageNode{
    [WJActivityView show];
}
- (void)imageNodeDidFinishDecoding:(ASNetworkImageNode *)imageNode{
    [WJActivityView dismiss];
}
@end
