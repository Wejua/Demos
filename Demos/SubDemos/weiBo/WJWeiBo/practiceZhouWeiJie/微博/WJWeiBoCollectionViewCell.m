//
//  WJCollectionViewCell.m
//  practiceZhouWeiJie
//
//  Created by WJMac on 2018/2/9.
//  Copyright © 2018年 陆杰毅. All rights reserved.
//

#import "WJWeiBoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "WJCollectionViewFlowLayout.h"
#import "MiddleCollectionViewCell.h"
#import "WJRetweetedView.h"



@interface WJWeiBoCollectionViewCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
//上部
@property(weak,nonatomic)UIImageView *touXiangImgV;
@property(weak,nonatomic)UIView *detailV;
@property(weak,nonatomic)UILabel *nameLabel;
@property(weak,nonatomic)UILabel *jiFenZhongQianLabel;
@property(weak,nonatomic)UILabel *laiZiLabel;
@property(weak,nonatomic)UILabel *naLiLabel;
@property(weak,nonatomic)UIImageView *huangGuanImgV;
@property(weak,nonatomic)UIImageView *hongBaoImgV;
//中间
@property(weak,nonatomic)UILabel *middleTitleLabel;
@property(weak,nonatomic)WJPicturesCollectionView *middleCollectionV;
@property(weak,nonatomic)WJRetweetedView *retweetedView;
//底部
@property(weak,nonatomic)UIImageView *separateLine;
@property(weak,nonatomic)UILabel *zhuanFaLabel;
@property(weak,nonatomic)UIImageView *pingLunImg;
@property(weak,nonatomic)UILabel *pingLunLabel;
@property(weak,nonatomic)UIImageView *zanImg;
@property(weak,nonatomic)UILabel *zanLabel;
@end
@implementation WJWeiBoCollectionViewCell

#define middleCollectionVTag 2
//3，调用initWithFrame初始化cell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        //个人头像
        UIImageView *touXiangImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"touXiang"] highlightedImage:nil];
        _touXiangImgV = touXiangImgV;
//        touXiangImgV.layer.cornerRadius = 20;
//        [touXiangImgV.layer setMasksToBounds:YES];
        [self.contentView addSubview:touXiangImgV];
        //个人信息
        UIView *detailV = [[UIView alloc]init];
        _detailV = detailV;
        [self.contentView addSubview:detailV];
                //名字
                UILabel *nameLabel = [[UILabel alloc]init];
                _nameLabel = nameLabel;
                nameLabel.text = @"绝地求生情报站";
                nameLabel.font = [UIFont systemFontOfSize:15];
                nameLabel.textColor = [UIColor colorWithRed:239/255.0 green:98/255.0 blue:32/255.0 alpha:1.0];
                nameLabel.textAlignment = NSTextAlignmentLeft;
                [detailV addSubview:nameLabel];
                //皇冠
                UIImageView *huangGuanImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huangGuan"] highlightedImage:nil];
                _huangGuanImgV = huangGuanImgV;
                [detailV addSubview:huangGuanImgV];
                //红包
                UIImageView *hongBaoImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiaoHongBao"] highlightedImage:nil];
                self.hongBaoImgV = hongBaoImgV;
                [detailV addSubview:hongBaoImgV];
                //几分钟前
                UILabel *jiFenZhongQianLabel = [[UILabel alloc]init];
                _jiFenZhongQianLabel = jiFenZhongQianLabel;
                jiFenZhongQianLabel.text = @"3分钟前";
                jiFenZhongQianLabel.font = [UIFont systemFontOfSize:12];
                jiFenZhongQianLabel.textColor = [UIColor lightGrayColor];
                jiFenZhongQianLabel.textAlignment = NSTextAlignmentLeft;
                [detailV addSubview:jiFenZhongQianLabel];
                //来自
                UILabel *laiZiLabel = [[UILabel alloc]init];
                _laiZiLabel = laiZiLabel;
                laiZiLabel.text = @"来自";
                laiZiLabel.font = [UIFont systemFontOfSize:12];
                laiZiLabel.textColor = [UIColor lightGrayColor];
                laiZiLabel.textAlignment = NSTextAlignmentLeft;
                [detailV addSubview:laiZiLabel];
                //来自哪里
                UILabel *naLiLabel = [[UILabel alloc]init];
                _naLiLabel = naLiLabel;
                naLiLabel.text = @"iPhone";
                naLiLabel.font = [UIFont systemFontOfSize:12];
                naLiLabel.textColor = [UIColor lightGrayColor];
                naLiLabel.textAlignment = NSTextAlignmentLeft;
                [detailV addSubview:naLiLabel];
        
        
            //middleTitleLabel
        UILabel *middleTitleLabel = [[UILabel alloc]init];
        _middleTitleLabel = middleTitleLabel;
        middleTitleLabel.text = @"song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni song jing jing,wo ai ni ";
        _middleTitleLabel.numberOfLines = 0;
        middleTitleLabel.font = [UIFont systemFontOfSize:16];
        middleTitleLabel.textColor = [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0];
        middleTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:middleTitleLabel];
        //中间图片页面
        WJCollectionViewFlowLayout *layout = [[WJCollectionViewFlowLayout alloc]init];//CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)
        layout.minimumInteritemSpacing = space;
        layout.minimumLineSpacing = space;
        WJPicturesCollectionView *middleCollectionV = [[WJPicturesCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [middleCollectionV registerClass:[MiddleCollectionViewCell class] forCellWithReuseIdentifier:@"MiddleCollectionViewCell"];
        middleCollectionV.delegate = self;
        middleCollectionV.dataSource = self;
        middleCollectionV.tag = middleCollectionVTag;
        _middleCollectionV = middleCollectionV;
        _middleCollectionV.backgroundColor = [UIColor whiteColor];;
        _middleCollectionV.scrollEnabled = NO;
        [self.contentView addSubview:middleCollectionV];
        
        
        //retweeted界面
        WJRetweetedView *retweetedView = [[WJRetweetedView alloc]init];
        _retweetedView = retweetedView;
        [self.contentView addSubview:retweetedView];
        
        
        //separateLine
        UIImageView *separateLine = [[UIImageView alloc]init];
        _separateLine = separateLine;
        separateLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.contentView addSubview:separateLine];
        //bottom,zhuanFaImg
        UIImageView *zhuanFaImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fenXiang"] highlightedImage:nil];
        _zhuanFaImg = zhuanFaImg;
        [self.contentView addSubview:zhuanFaImg];
        //zhuanFaLabel
        UILabel *zhuanFaLabel = [[UILabel alloc]init];
        _zhuanFaLabel = zhuanFaLabel;
        zhuanFaLabel.text = @"转发";
        zhuanFaLabel.font = [UIFont systemFontOfSize:12];
        zhuanFaLabel.textColor = [UIColor lightGrayColor];
        zhuanFaLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:zhuanFaLabel];
        //pingLunImg
        UIImageView *pingLunImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pingLun"] highlightedImage:nil];
        _pingLunImg = pingLunImg;
        [self.contentView addSubview:_pingLunImg];
        //pingLunLabel
        UILabel *pingLunLabel = [[UILabel alloc]init];
        _pingLunLabel = pingLunLabel;
        pingLunLabel.text = @"2";
        pingLunLabel.font = [UIFont systemFontOfSize:12];
        pingLunLabel.textColor = [UIColor lightGrayColor];
        pingLunLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:pingLunLabel];
        //zanImg
        UIImageView *zanImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"] highlightedImage:nil];
        _zanImg = zanImg;
        [self.contentView addSubview:zanImg];
        //zanLabel
        UILabel *zanLabel = [[UILabel alloc]init];
        _zanLabel = zanLabel;
        zanLabel.text = @"41";
        zanLabel.font = [UIFont systemFontOfSize:12];
        zanLabel.textColor = [UIColor lightGrayColor];
        zanLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:zanLabel];
    }
    return self;
}
//8，调用cell的layoutSubViews方法布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    _touXiangImgV.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _huangGuanImgV.translatesAutoresizingMaskIntoConstraints = NO;
    _hongBaoImgV.translatesAutoresizingMaskIntoConstraints = NO;
    _jiFenZhongQianLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _laiZiLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _naLiLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailV.translatesAutoresizingMaskIntoConstraints = NO;
    //self.contentView
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[UIScreen mainScreen].bounds.size.width]];
    //touXiangImgV
            //top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_touXiangImgV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:insets]];
            //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_touXiangImgV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:insets]];
            //height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_touXiangImgV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
            //width
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_touXiangImgV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    //detailV
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_touXiangImgV attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_touXiangImgV attribute:NSLayoutAttributeRight multiplier:1.0 constant:insets]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets]];
    [_detailV addConstraint:[NSLayoutConstraint constraintWithItem:_jiFenZhongQianLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_detailV attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    //名字，皇冠，红包
    [_detailV addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_nameLabel]-3-[_huangGuanImgV]-3-[_hongBaoImgV]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"_nameLabel":_nameLabel,@"_huangGuanImgV":_huangGuanImgV,@"_hongBaoImgV":_hongBaoImgV}]];
    [_detailV addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_detailV attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [_detailV addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_detailV attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    //几分钟前label
    [_detailV addConstraint:[NSLayoutConstraint constraintWithItem:_jiFenZhongQianLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:space]];
    [_detailV addConstraint:[NSLayoutConstraint constraintWithItem:_jiFenZhongQianLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    //哪里label
    [_detailV addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_jiFenZhongQianLabel]-3-[_laiZiLabel]-0-[_naLiLabel]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"_jiFenZhongQianLabel":_jiFenZhongQianLabel,@"_laiZiLabel":_laiZiLabel,@"_naLiLabel":_naLiLabel}]];
    
    //_middleTitleLabel
    _middleTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _middleCollectionV.translatesAutoresizingMaskIntoConstraints = NO;
    _retweetedView.translatesAutoresizingMaskIntoConstraints = NO;
    //top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_touXiangImgV attribute:NSLayoutAttributeBottom multiplier:1.0 constant:insets]];
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleTitleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:insets]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleTitleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets]];
    //middlecollectionV
    //top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleCollectionV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_middleTitleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:insets]];
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleCollectionV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:insets]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleCollectionV attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets]];
    //bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_middleCollectionV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_separateLine attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    //retweetedview
    //top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_middleTitleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:insets]];
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:insets]];
    //bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_separateLine attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_retweetedView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets]];
    
    
    //bottomV
    _zhuanFaImg.translatesAutoresizingMaskIntoConstraints = NO;
    _zhuanFaLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _pingLunImg.translatesAutoresizingMaskIntoConstraints = NO;
    _pingLunLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _zanImg.translatesAutoresizingMaskIntoConstraints = NO;
    _zanLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _separateLine.translatesAutoresizingMaskIntoConstraints = NO;
    //separateLine
    //left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separateLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:insets]];
    //right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separateLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets]];
    //bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separateLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_zhuanFaImg attribute:NSLayoutAttributeTop multiplier:1.0 constant:-insets]];
    //height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separateLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.5]];
    //转发，评论，赞
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_zhuanFaImg]-3-[_zhuanFaLabel]-(>=3)-[_pingLunImg]-3-[_pingLunLabel]-(>=3)-[_zanImg]-3-[_zanLabel]-50-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"_zhuanFaImg":_zhuanFaImg,@"_zhuanFaLabel":_zhuanFaLabel,@"_pingLunImg":_pingLunImg,@"_pingLunLabel":_pingLunLabel,@"_zanImg":_zanImg,@"_zanLabel":_zanLabel}]];
    //centerX
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pingLunImg attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    //bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_zhuanFaImg attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets]];

}
-(void)setModel:(WJUserInfoModel *)model{
    CGFloat borderWidth = 0.5f;
    [_touXiangImgV sd_setImageWithURL:[NSURL URLWithString:model.profile_image_url] placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // borderWidth 表示边框的宽度
        CGFloat imageW = image.size.width + 2 * borderWidth;
        CGFloat imageH = imageW;
        CGSize imageSize = CGSizeMake(imageW, imageH);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        // borderColor表示边框的颜色
        [[UIColor lightGrayColor] set];
        CGFloat bigRadius = imageW * 0.5;
        CGFloat centerX = bigRadius;
        CGFloat centerY = bigRadius;
        CGContextAddArc(context, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
        CGContextFillPath(context);
        CGFloat smallRadius = bigRadius - borderWidth;
        CGContextAddArc(context, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
        CGContextClip(context);
        [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _touXiangImgV.image = newImage;
    }];
    _nameLabel.text = model.name;
    _jiFenZhongQianLabel.text = model.created_at;
    if(!model.source){
        _laiZiLabel.text = @"";
    }else{
        _laiZiLabel.text = @"来自";
    }
    _naLiLabel.text = model.source;
    //middleTitleLabel
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 4;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dic1 = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [model.attriButedText addAttributes:dic1 range:NSMakeRange(0, model.attriButedText.length)];
    _middleTitleLabel.attributedText = [[NSAttributedString alloc]initWithString:model.text attributes:dic1];
//    _middleTitleLabel.attributedText = model.attriButedText;
    
    if(!model.text){
        _middleTitleLabel.attributedText = nil;
    }
    _zhuanFaLabel.text = [model.reposts_count isEqualToString:@"0"]?@"转发":model.reposts_count;
    _pingLunLabel.text = [model.comments_count isEqualToString:@"0"]?@"评论":model.comments_count;
    _zanLabel.text = [model.attitudes_count isEqualToString:@"0"]?@"赞":model.attitudes_count;
    //这句不能少
    _model = model;
    //图片
    if(_model.pic_urls.count){
        _retweetedView.hidden = YES;
        _middleCollectionV.hidden = NO;
        [_middleCollectionV reloadData];
    }else{
        _middleCollectionV.hidden = YES;
        _retweetedView.hidden = NO;
        //retweetedView
        if(_model.retweeted_status.text){
            NSDictionary *dic2 = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]};
            _retweetedView.retweetedLabel.attributedText = [[NSAttributedString alloc]initWithString:_model.retweeted_status.text attributes:dic2];
        }else{
            _retweetedView.retweetedLabel.attributedText = nil;
        }
        _retweetedView.model = _model.retweeted_status;
        _retweetedView.retweetedImgCltV.model = _model.retweeted_status;
        [_retweetedView.retweetedImgCltV reloadData];
    }
}
#pragma mark - middleCollecitonVewCellDatasource
//9，调用嵌套collectionView的数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.pic_urls.count;
}
//13，出列嵌套cell。.16，
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MiddleCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"MiddleCollectionViewCell" forIndexPath:indexPath];
    if (_model.pic_urls.count == 1) {
        cell.model = _model.bmiddle_pic;
    }else{
        cell.model = _model.pic_urls[indexPath.item];
    }
    return cell;
}

#pragma mark delegateFlowLayout
//12,获取所有嵌套cell高度，后面初始化，出列，告诉代理，布局，
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat NineImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets-space*2)/3;
//    CGFloat oneImgWidth = ([UIScreen mainScreen].bounds.size.width-2*insets)/2;
    if(_model.pic_urls.count == 1){
        return _model.oneImgeSize;
    }else{
        return CGSizeMake(NineImgWidth,NineImgWidth);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == middleCollectionVTag) {
        //通知控制器切换图片浏览器界面
        [[NSNotificationCenter defaultCenter]postNotificationName:@"retweetedCollectionViewDidSelectedItem" object:nil userInfo:@{@"indexPath":indexPath,@"imageUrls":_model.pic_urls,@"object":self}];
    }
}
//计算相对窗口位置
-(CGRect)fromRect:(NSIndexPath *)indexPath{
    CGRect frame = [_middleCollectionV cellForItemAtIndexPath:indexPath].frame;
    CGRect rect =[_middleCollectionV convertRect:frame toView:[UIApplication sharedApplication].keyWindow];
    return rect;
}
//计算在photobroser中位置
-(CGRect)fullScreeRect:(NSIndexPath *)indexPath{
    //获取图片
    NSString *url = _model.pic_urls[indexPath.row];
    NSString *key = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:key];
    CGFloat scale = image.size.height/image.size.width;
    CGFloat height = scale * SCREENSIZE.width;
    CGFloat width = SCREENSIZE.width;
    CGFloat Y = (SCREENSIZE.height - height) *0.5;
    if (Y<0) {
        Y = 0;
    }
    return CGRectMake(0, Y, width, height);
}
@end

