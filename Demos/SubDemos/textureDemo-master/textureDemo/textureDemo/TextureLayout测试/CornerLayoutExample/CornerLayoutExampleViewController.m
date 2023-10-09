//
//  CornerLayoutExampleViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/3.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "CornerLayoutExampleViewController.h"
#import "CornerLayoutExampleView.h"

@interface CornerLayoutExampleViewController ()
@property (nonatomic,strong)ASDisplayNode *demoView;
@end

@implementation CornerLayoutExampleViewController
- (instancetype)init
{
    self = [super initWithNode:[ASDisplayNode new]];
    if (self) {
        self.node.backgroundColor = [UIColor whiteColor];
        _demoView = [CornerLayoutExampleView new];
        [self.node addSubnode:_demoView];
        __weak __typeof(self) weakself = self;
        self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            ASCenterLayoutSpec *centerLayoutSpec = [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY child:weakself.demoView];
            return centerLayoutSpec;
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
