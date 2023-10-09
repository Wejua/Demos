//
//  SocialAppLayoutViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/8.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "SocialAppLayoutViewController.h"
//#import "Post+CoreDataProperties.h"
#import "Post.h"
#import "SocialCellNode.h"

@interface SocialAppLayoutViewController ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic,strong)ASTableNode *tableNode;
@property (nonatomic,strong)NSMutableArray *socialAppDataSource;
@end

@implementation SocialAppLayoutViewController
- (instancetype)init
{
    ASDisplayNode *node = [ASDisplayNode new];
    
    self = [super initWithNode:node];
    if (self) {
        self.node.backgroundColor = [UIColor whiteColor];
        //添加子控件并布局
        _tableNode = [ASTableNode new];
        [self.node addSubnode:_tableNode];
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        
        __weak __typeof(self) weakself = self;
        self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:weakself.tableNode];
        };
        [self createSocialAppDataSource];
    }
    return self;
}
- (void)createSocialAppDataSource
{
    _socialAppDataSource = [[NSMutableArray alloc] init];
    
    Post *newPost = [[Post alloc] init];
    newPost.name = @"Apple Guy";
    newPost.username = @"@appleguy";
    newPost.photo = @"https://avatars1.githubusercontent.com/u/565251?v=3&s=96";
    newPost.post = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    newPost.time = @"3s";
    newPost.media = @"";
    newPost.via = 0;
    newPost.likes = arc4random_uniform(74);
    newPost.comments = arc4random_uniform(40);
    [_socialAppDataSource addObject:newPost];
    
    newPost = [[Post alloc] init];
    newPost.name = @"Huy Nguyen";
    newPost.username = @"@nguyenhuy";
    newPost.photo = @"https://avatars2.githubusercontent.com/u/587874?v=3&s=96";
    newPost.post = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    newPost.time = @"1m";//newPost.time = @"1m";
    newPost.media = @"";
    newPost.via = 1;
    newPost.likes = arc4random_uniform(74);
    newPost.comments = arc4random_uniform(40);
    [_socialAppDataSource addObject:newPost];
    
    newPost = [[Post alloc] init];
    newPost.name = @"Alex Long Name";
    newPost.username = @"@veryyyylongusernameveryyyylongusernameveryyyylongusername";
    newPost.photo = @"https://avatars1.githubusercontent.com/u/8086633?v=3&s=96";
    newPost.post = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    newPost.time = @"3:02";
    newPost.media = @"http://www.ngmag.ru/upload/iblock/f93/f9390efc34151456598077c1ba44a94d.jpg";
    newPost.via = 2;
    newPost.likes = arc4random_uniform(74);
    newPost.comments = arc4random_uniform(40);
    [_socialAppDataSource addObject:newPost];
    
    newPost = [[Post alloc] init];
    newPost.name = @"Vitaly Baev";
    newPost.username = @"@vitalybaev";
    newPost.photo = @"https://avatars0.githubusercontent.com/u/724423?v=3&s=96";
    newPost.post = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. https://github.com/facebook/AsyncDisplayKit Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    newPost.time = @"yesterday";
    newPost.media = @"";
    newPost.via = 1;
    newPost.likes = arc4random_uniform(74);
    newPost.comments = arc4random_uniform(40);
    [_socialAppDataSource addObject:newPost];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma ASTableNodeDatasource
-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return _socialAppDataSource.count;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    Post *post = _socialAppDataSource[indexPath.row];
    return ^{
        SocialCellNode *node = [[SocialCellNode alloc]initWithPost:post];
//        node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
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
