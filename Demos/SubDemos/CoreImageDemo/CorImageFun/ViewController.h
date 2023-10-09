//
//  ViewController.h
//  CorImageFun
//
//  Created by 位杰周 on 16/2/2.
//  Copyright © 2016年 位杰周. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *amounSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountSlider;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
- (IBAction)valueChange:(id)sender;

@end

