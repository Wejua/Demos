//
//  WJFaXianShiPinTableViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/3/5.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJFaXianShiPinTableViewCell.h"
#import "WJFaXianShiPinTableViewCell/WJShiPinBottomView.h"
#import "AVKit/AVKit.h"

@interface WJFaXianShiPinTableViewCell()
@property(weak,nonatomic)UIImageView *topImageV;
@property(weak,nonatomic)UILabel *middleLabel;
@property(weak,nonatomic)AVPlayerLayer *AVLayer;

//@property(weak,nonatomic)UIImageView *portraitImgV;
//@property(weak,nonatomic)UILabel *portraitDetailLable;
//@property(weak,nonatomic)UIImageView *pingLun;
//@property(weak,nonatomic)UIImageView *fenXiang;
//@property(weak,nonatomic)UIImageView *zanImgV;
//@property(weak,nonatomic)UILabel *zanLabel;
@end
@implementation WJFaXianShiPinTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        //topImageV
        UIImageView *topImageV = [[UIImageView alloc]init];
        _topImageV = topImageV;
        _topImageV.backgroundColor = [UIColor blackColor];
        topImageV.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:topImageV];
        //middleLabel
        UILabel *middleLabel = [[UILabel alloc]init];
        _middleLabel = middleLabel;
        middleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        middleLabel.text = @"song jing jing ,wo hdagagen kuai jgagdiu neng jia nagagdao ni d !";
        middleLabel.font = [UIFont systemFontOfSize:17];
        middleLabel.numberOfLines = 0;
        middleLabel.textColor = [UIColor blackColor];
        middleLabel.textAlignment = NSTextAlignmentLeft;
        [middleLabel sizeToFit];
        [self.contentView addSubview:middleLabel];
        
        WJShiPinBottomView *bottomView = [[WJShiPinBottomView alloc]init];
        _bottomView = bottomView;
        bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:bottomView];
        
        //增加AVPlayerViewController
        [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
            AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/3/2/9/EDB9RQ129/SD/EDB9RQ129-mobile.mp4"]];
            //    AVPlayerViewController *vc = [[AVPlayerViewController alloc]init];
            //    vc.view.frame = _topImageV.bounds;
            //    vc.player = player;
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
                _AVLayer = layer;
                [_topImageV.layer addSublayer:layer];
            }];
        }];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //topImageV
    [_topImageV.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:insets].active = YES;
    [_topImageV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    [_topImageV.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-insets].active = YES;
    [_topImageV.heightAnchor constraintEqualToConstant:SCREENSIZE.width*0.5].active = YES;
    
    //_middleLabel
    [_middleLabel.bottomAnchor constraintEqualToAnchor:_bottomView.topAnchor].active = YES;
    [_middleLabel.topAnchor constraintEqualToAnchor:_topImageV.bottomAnchor constant:insets].active = YES;
    [_middleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    [_middleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-insets].active = YES;
    
    //bottomView
    [_bottomView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:insets].active = YES;
    [_bottomView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-insets].active = YES;
    NSLayoutConstraint *bottomViewBottom = [_bottomView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor];
    bottomViewBottom.priority = UILayoutPriorityDefaultHigh;
    bottomViewBottom.active = YES;
    
    _AVLayer.frame = _topImageV.bounds;
}


@end
