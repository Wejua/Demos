//
//  postNode.m
//  textureDemo
//
//  Created by jieyi lu on 2018/4/10.
//  Copyright © 2018年 jieyi lu. All rights reserved.
//

#import "postNode.h"

@implementation postNode
{
//    ASTextNode *self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:@"【三亚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个三亚】【四天三晚】点击报名 http://www.baidu.com 获取蜜月地昂啊的房啊的大噶法定啊的结果啊的#5dmark#东昂弄个我那个 熬干啊顶啊；经啊递送 <全文> 那个那时刚康地昂爱你的个 i 啊你个" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
        //    //加图片
        //    NSTextAttachment *attachment = [NSTextAttachment new];
        //    attachment.image = [UIImage imageNamed:@"d_ganmao"];
        //    attachment.bounds = CGRectMake(0, 0, 20, 20);
        //    [mutableAttributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        self.attributedText = mutableAttributedString;
        
        
        CGRect imageRect = CGRectMake(55, 55, 100, 100);
        self.exclusionPaths = @[[UIBezierPath bezierPathWithOvalInRect:imageRect]];
        ASImageNode *imageNode = [ASImageNode new];
        imageNode.image = [UIImage imageNamed:@"d_ganmao"];
        [self addSubnode:imageNode];
        imageNode.frame = imageRect;
        self.placeholderEnabled = YES;
        self.userInteractionEnabled = YES;
        self.passthroughNonlinkTouches = YES;
        
        //添加一个UI控件
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(200, 100, 30, 30);
    }
    return self;
}
-(void)layoutDidFinish{
    [super layoutDidFinish];
    self.layer.as_allowsHighlightDrawing = YES;
    //找到文字位置
    NSString *pattern =@"【四天三晚】";
    NSRegularExpression *detector = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    [detector matchesInString:self.attributedText.string options:kNilOptions range:NSMakeRange(0, self.attributedText.length)];
    NSRange range = [detector rangeOfFirstMatchInString:self.attributedText.string options:kNilOptions range:NSMakeRange(0, self.attributedText.length)];
    CGRect frame = [self frameForTextRange:range];
    ASImageNode *imageNode = [ASImageNode new];
    imageNode.image = [UIImage imageNamed:@"d_ganmao"];
    [self addSubnode:imageNode];
    imageNode.frame = frame;
    
    
    
    //一下方法找到几个后会出错，现在还没有找到原因
    //    [detector enumerateMatchesInString:self.attributedText.string options:kNilOptions range:NSMakeRange(0, self.attributedText.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
    //        if (result.resultType == NSTextCheckingTypeRegularExpression) {
    //            CGRect frame = [self frameForTextRange:result.range];
    //            ASImageNode *imageNode = [ASImageNode new];
    //            imageNode.image = [UIImage imageNamed:@"d_ganmao"];
    //            [self addSubnode:imageNode];
    //            imageNode.frame = frame;
    //        }
    //    }];
}

@end
