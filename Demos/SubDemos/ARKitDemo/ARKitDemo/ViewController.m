//
//  ViewController.m
//  ARKitDemo
//
//  Created by zhouweijie1 on 2021/2/22.
//


/*
 This sample code project requires:

 An iOS device with front-facing TrueDepth camera:
 iPhone X, iPhone XS, iPhone XS Max, or iPhone XR.
 iPad Pro (11-inch) or iPad Pro (12.9-inch, 3rd generation).

 iOS 11.0 or later.
 Xcode 10.0 or later.

 ARKit is not available in iOS Simulator.
 */

#import "ViewController.h"
#import <ARKit/ARKit.h>

@interface ViewController ()<ARSCNViewDelegate>
//视图
@property (nonatomic, strong) ARSCNView *sceneView;
//

//模型
@property (nonatomic, strong) SCNReferenceNode *robotNode;
@property (nonatomic, strong) SCNNode *eyeLeftNode;
@property (nonatomic, strong) SCNNode *eyeRightNode;
@property (nonatomic, strong) SCNNode *jawNode;
//
@end

@implementation ViewController
{
    CGFloat _originalJawY;
    CGFloat _originalJawHeight;
}

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self sceneView]];
    self.sceneView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //防止屏幕变暗
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    //重置Session
    [self resetTracking];
}

#pragma mark - private
- (void)resetTracking {
    if (ARFaceTrackingConfiguration.isSupported) {
        ARFaceTrackingConfiguration *configuration = [[ARFaceTrackingConfiguration alloc] init];
        [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking];
    }
}

#pragma mark - ARSessionObserver
//锚点就是固定3D模型的地方，也就是位置和朝向信息。
//这个方法处理跟踪失败情况
- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    NSLog(@"\nSessionError:%@\n", error);
    [self resetTracking];
}

#pragma - mark - ARSCNViewDelegate
//这里用ARSCNView显示内容，ARSCNView通过ARSCNViewDelegate获取模型数据并显示。也可以用ARSKView/ARView/Metal
//ARFaceTrackingConfiguration配置下，检测到人脸就会添加ARFaceAnchor，而添加了锚点（anchor）就会调用这个方法。这个方法返回ARFaceAnchor对应的3D模型，也就是机器头（RobotHead）
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:ARFaceAnchor.class]) {return nil;}
    return [self robotNode];
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if ([anchor isKindOfClass:ARFaceAnchor.class]) {
        //ARFaceAnchor中的blendShapes属性存了脸部各个部位的位置信息，将这些位置信息同步到3D模型中，就能实现模型和人脸的动作同步
        ARFaceAnchor *faceAnchor = (ARFaceAnchor *)anchor;
        //左眼眨眼
        CGFloat eyeBlinkLeft =  1 - faceAnchor.blendShapes[ARBlendShapeLocationEyeBlinkLeft].floatValue;
        SCNVector3 newLeftScale = self.eyeLeftNode.scale;
        newLeftScale.z = eyeBlinkLeft;
        self.eyeLeftNode.scale = newLeftScale;
        //右眼眨眼
        CGFloat eyeBlinkRight =  1 - faceAnchor.blendShapes[ARBlendShapeLocationEyeBlinkRight].floatValue;
        SCNVector3 newRightScale = self.eyeRightNode.scale;
        newRightScale.z = eyeBlinkRight;
        self.eyeRightNode.scale = newRightScale;
        //下巴动
        CGFloat jawOpen = faceAnchor.blendShapes[ARBlendShapeLocationJawOpen].floatValue;
        SCNVector3 newPosition = self.jawNode.position;
        newPosition.y = _originalJawY - _originalJawHeight * jawOpen;
        self.jawNode.position = newPosition;
    }
}

#pragma mark - lazy
- (ARSCNView *)sceneView {
    if (_sceneView == nil) {
        _sceneView = [[ARSCNView alloc] init];
        _sceneView.delegate = self;
    }
    return _sceneView;
}

- (SCNReferenceNode *)robotNode {
    if (!_robotNode) {
        //加载3D型
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"robotHead" ofType:@"scn"]] ;
        SCNReferenceNode *node = [[SCNReferenceNode alloc] initWithURL:url];
        [node load];
        _robotNode = node;
        //加载3D模型中的子Node
        [self eyeLeftNode];
        [self eyeRightNode];
        [self jawNode];
    }
    return _robotNode;
}

- (SCNNode *)eyeLeftNode {
    if (!_eyeLeftNode) {
        _eyeLeftNode = [self.robotNode childNodeWithName:@"eyeLeft" recursively:YES];
    }
    return _eyeLeftNode;
}

- (SCNNode *)eyeRightNode {
    if (!_eyeRightNode) {
        _eyeRightNode = [self.robotNode childNodeWithName:@"eyeRight" recursively:YES];
    }
    return _eyeRightNode;
}

- (SCNNode *)jawNode {
    if (!_jawNode) {
        _jawNode = [self.robotNode childNodeWithName:@"jaw" recursively:YES];
        SCNVector3 max;
        SCNVector3 min;
        if ([_jawNode getBoundingBoxMin:&min max:&max]) {
            _originalJawHeight = max.y - min.y;
        }
        _originalJawY = _jawNode.position.y;
    }
    return _jawNode;
}
@end
