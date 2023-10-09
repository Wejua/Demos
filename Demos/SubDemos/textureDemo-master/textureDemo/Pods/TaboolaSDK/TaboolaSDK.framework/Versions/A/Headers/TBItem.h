//
//  TBItem.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBImageView.h"
#import "TBTitleLabel.h"
#import "TBBrandingLabel.h"
#import "TBDescriptionLabel.h"


@class TBItemModel;

@interface TBItem : NSObject

- (instancetype)initWithItemModel:(TBItemModel *)model;

//create UIViews manually
- (TBImageView *)thumbnailView;
- (TBTitleLabel *)titleView;
- (TBBrandingLabel *)brandingView;
- (TBDescriptionLabel *)descriptionView;
- (NSDictionary *)extraDataDictionary;

//create UIViews from storyboard
- (void)initTitleView:(TBTitleLabel *)titleLabel;
- (void)initBrandingView:(TBBrandingLabel *)brandingLabel;
- (void)initDescriptionView:(TBDescriptionLabel *)descriptionLabel;
- (void)initThumbnailView:(TBImageView *)imageView;

-(void)handleClickEvent;
-(void)notifyVisibleEvent;

@end
