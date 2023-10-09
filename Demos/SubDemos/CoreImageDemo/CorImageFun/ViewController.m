//
//  ViewController.m
//  CorImageFun
//
//  Created by 位杰周 on 16/2/2.
//  Copyright © 2016年 位杰周. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
CIContext *context;
CIFilter *filterd;
CIImage *beginImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1
    NSString *filePath =
    [[NSBundle mainBundle] pathForResource:@"v" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
//
//    // 2
//    CIImage *beginImage =
//    [CIImage imageWithContentsOfURL:fileNameAndPath];
//    
//    // 3
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
//                                  keysAndValues: kCIInputImageKey, beginImage,
//                        @"inputIntensity", @0.8, nil];
//    CIImage *outputImage = [filter outputImage];
//    
//    // 4
//    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
//    self.imageV.image = newImage;
    
    
//    CIImage *beginImage =
//    [CIImage imageWithContentsOfURL:fileNameAndPath];
//    
//    // 1
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
//                                  keysAndValues: kCIInputImageKey, beginImage,
//                        @"inputIntensity", @0.8, nil];
    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:nil];
    
    filterd = [CIFilter filterWithName:@"CISepiaTone"
                        keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity",
              @0.8, nil];
    CIImage *outputImage = [filterd outputImage];
    
    // 2
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    // 3
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.imageV.image = newImage;
    
    // 4  
    CGImageRelease(cgimg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChange:(id)sender {
    UISlider *slider = sender;
    float slideValue = slider.value;
    
    [filterd setValue:@(slideValue)
              forKey:@"inputIntensity"];
    CIImage *outputImage = [filterd outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage
                                     fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.imageV.image = newImage;
    
    CGImageRelease(cgimg);
}
@end
