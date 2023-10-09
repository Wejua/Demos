//
//  YYVideoDetailModel.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

//视频Model
class VideoDetailModel: YYBaseModel {
    
    var skuList: [HomeGoodsModel] = []//商品列表
    ///用户种类
    var identify: String?
    ///视频id
    var id : String?
    ///视频名字
    var name: String?
    ///视频所属用户id
    var yipaiId : String?
    ///用户头像
    var headPic : String?
    ///没用
    var fileId :  String?
    ///没用
    var title : String?
    ///源视频地址
    var originalUrl : String?
    ///720视频地址
    var url720 : String?
    ///粉丝数
    var fanNum : String?
    ///视频数量
    var videoNum : String?
    ///收到的赞
    var videoBeZanNum : String?
    ///视频宽
    var width : Int?
    ///视频高
    var length : Int?
    ///封面图
    var coverUrl : String?
    ///视频第一帧
    var firstFrame : String?
    ///视频时长
    var timeSpan : Double?
    ///音乐ID
    var musicId : String?
    ///音乐名
    var musicName : String?
    ///音乐地址
    var musicUrl : String?
    ///音乐封面
    var musicCoverUrl : String?
    ///音乐所属用户ID
    var musicYipaiId : String?
    ///音乐所属用户吗名字
    var musicNickName : String?
    ///音乐所属用户头像
    var musicUserHeadPic : String?
    ///话题ID
    var topicId : String?
    ///话题名字
    var topicName : String?
    ///视频描述
    var description : String?
    ///点赞数
    var likeNum : String?
    ///评论数
    var commentNum : String?
    ///加载数
    var loadNum : String?
    ///下载数
    var downloadNum : String?
    ///分享数
    var shareNum : String?
    /*
     状态（0未经系统鉴黄 1系统鉴黄没问题 2系统鉴黄有问题 3一审中 4一审过 5一审被封禁 6二审中 7二审被封禁 8正常 9被举报审核中 10封禁 11回收站 12删除）
     */
    var status : Int?
    ///是否点过赞0未点赞1是点赞（未登录状态下是null）
    var isLiked : Int?
    ////相互关注状态 0 登录用户关注了视频主人 1 对方关注了我 2 相互关注 3相互不关注（未登录状态下是null）
    var isAttentioned : Int?
    ///用户昵称
    var nickName : String?
    ///是否是示例（话题方面用）
    var isExample : Int?
    //是否是热门（话题方面用）
    var isHot: Int?
    ///第几个示例（话题）
    var videoseq : String?
    //是否是首发
    var isFirst : Int? //0:否 1：是
    //视频广告
    var recommend : Int? //1推荐 2置顶推荐 3广告推荐

    //TODO: - 草稿箱需要的音乐的
    var locationVideoPath : String? //本地的视频地址
    var locationCoverPath : String? //本地的音乐地址
    var bgmModel : MusicDetailModel? //背景音乐模型
    var isdraft : Bool = false //是否是草稿
    
    //下载地址
    var watermark : String?
}
