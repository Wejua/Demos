//
//  ASVideoNodeViewController.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/8.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "ASVideoNodeViewController.h"

@interface ASVideoNodeViewController ()<ASVideoNodeDelegate>

@end

@implementation ASVideoNodeViewController

- (instancetype)init
{
    ASDisplayNode *node = [ASDisplayNode new];
    self = [super initWithNode:node];
    if (self) {
        self.node.backgroundColor = [UIColor whiteColor];
        //添加子控件并布局
        ASVideoNode *videoNode1 = [ASVideoNode new];
        [self.node addSubnode:videoNode1];
        videoNode1.delegate = self;
        //placeholder image
        videoNode1.URL = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/en/5/52/Testcard_F.jpg"];
//        videoNode1.contentMode = UIViewContentModeScaleAspectFill;//只能设置占位图片的模式，不能设置video的模式，用下面这个
        videoNode1.gravity = AVLayerVideoGravityResize;
        videoNode1.asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"]];
        
        ASVideoNode *videoNode2 = [ASVideoNode new];
        [self.node addSubnode:videoNode2];
        videoNode2.delegate = self;
        //        videoNode1.contentMode = UIViewContentModeScaleAspectFill;//只能设置占位图片的模式，不能设置video的模式，用下面这个
        videoNode2.gravity = AVLayerVideoGravityResizeAspect;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"simon" ofType:@"mp4"];
        videoNode2.asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:path]];
        
        self.node.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            videoNode1.style.preferredSize = CGSizeMake(SCREENSIZE.width/2, SCREENSIZE.height/3);
            videoNode1.style.layoutPosition = CGPointMake(0, 0);
            videoNode1.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
            
            videoNode2.style.preferredSize = CGSizeMake(SCREENSIZE.height/2, SCREENSIZE.height/2);
            videoNode2.style.layoutPosition = CGPointMake(30, 300);
            videoNode2.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
            return [ASAbsoluteLayoutSpec absoluteLayoutSpecWithChildren:@[videoNode1,videoNode2]];
        };


    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{
    
}
#pragma mark - ASVideoNodeDelegate
/**
 * @abstract Delegate method invoked when the node's video has played to its end time.
 * @param videoNode The video node has played to its end time.
 */
- (void)videoDidPlayToEnd:(ASVideoNode *)videoNode{
    
}
/**
 * @abstract Delegate method invoked the node is tapped.
 * @param videoNode The video node that was tapped.
 * @discussion The video's play state is toggled if this method is not implemented.
 */
- (void)didTapVideoNode:(ASVideoNode *)videoNode{
    [videoNode play];
}
/**
 * @abstract Delegate method invoked when player changes state.
 * @param videoNode The video node.
 * @param state player state before this change.
 * @param toState player new state.
 * @discussion This method is called after each state change
 */
- (void)videoNode:(ASVideoNode *)videoNode willChangePlayerState:(ASVideoNodePlayerState)state toState:(ASVideoNodePlayerState)toState{
    NSLog(@"state:%lu,tostate:%lu",state,toState);
}
/**
 * @abstract Ssks delegate if state change is allowed
 * ASVideoNodePlayerStatePlaying or ASVideoNodePlayerStatePaused.
 * asks delegate if state change is allowed.
 * @param videoNode The video node.
 * @param state player state that is going to be set.
 * @discussion Delegate method invoked when player changes it's state to
 * ASVideoNodePlayerStatePlaying or ASVideoNodePlayerStatePaused
 * and asks delegate if state change is valid
 */
- (BOOL)videoNode:(ASVideoNode*)videoNode shouldChangePlayerStateTo:(ASVideoNodePlayerState)state{
    return YES;
}
/**
 * @abstract Delegate method invoked when player playback time is updated.
 * @param videoNode The video node.
 * @param timeInterval current playback time in seconds.
 */
- (void)videoNode:(ASVideoNode *)videoNode didPlayToTimeInterval:(NSTimeInterval)timeInterval{
    
}
/**
 * @abstract Delegate method invoked when the video player stalls.
 * @param videoNode The video node that has experienced the stall
 * @param timeInterval Current playback time when the stall happens
 */
- (void)videoNode:(ASVideoNode *)videoNode didStallAtTimeInterval:(NSTimeInterval)timeInterval{
    
}
/**
 * @abstract Delegate method invoked when the video player starts the inital asset loading
 * @param videoNode The videoNode
 */
- (void)videoNodeDidStartInitialLoading:(ASVideoNode *)videoNode{
    
}
/**
 * @abstract Delegate method invoked when the video is done loading the asset and can start the playback
 * @param videoNode The videoNode
 */
- (void)videoNodeDidFinishInitialLoading:(ASVideoNode *)videoNode{
    
}

/**
 * @abstract Delegate method invoked when the AVPlayerItem for the asset has been set up and can be accessed throught currentItem.
 * @param videoNode The videoNode.
 * @param currentItem The AVPlayerItem that was constructed from the asset.
 */
- (void)videoNode:(ASVideoNode *)videoNode didSetCurrentItem:(AVPlayerItem *)currentItem{
    
}
/**
 * @abstract Delegate method invoked when the video node has recovered from the stall
 * @param videoNode The videoNode
 */
- (void)videoNodeDidRecoverFromStall:(ASVideoNode *)videoNode{
    
}
/**
 * @abstract Delegate method invoked when an error occurs while trying trying to load an asset
 * @param videoNode The videoNode.
 * @param key The key of value that failed to load.
 * @param asset The asset.
 * @param error The error that occurs.
 */
- (void)videoNode:(ASVideoNode *)videoNode didFailToLoadValueForKey:(NSString *)key asset:(AVAsset *)asset error:(NSError *)error{
    
}

@end
