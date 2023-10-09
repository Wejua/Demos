//
//  HomeModel.swift
//  YYVideo
//
//  Created by 高彬 on 2018/8/31.
//  Copyright © 2018年 杨凯. All rights reserved.
//

import UIKit
import HandyJSON

//推荐视频
class HomeRecommendVideoListModel : BaseModel{
    var data: [VideoDetailModel]?
}

//视频列表
class HomeVideoListModel : BaseModel{
    var data: HomeVideiListModelData?
}

class HomeVideiListModelData: BaseInitModel {
    var count : Int?
    var currentPage : Int?
    var finalPage : Int?
    var firstPage : Int?
    var haveNext : Bool?
    var havePre : Bool?
    var nextPage : Int?
    var pageSize : Int?
    var prePage : Int?
    var list: [VideoDetailModel]?///视频列表
    var data: [VideoDetailModel]?///视频列表
    var rows: [VideoDetailModel]?///关注视频列表
}

//视频详情
class VideoDetailModelData: BaseModel {
    var data: VideoDetailModel?
}
//商品详情
class HomeGoodsModel: BaseInitModel{
    var url: String?//商品图片
    var id: String?
    var yipaiId: String?
    var videoId: String?
    var shelvesStatus: String?
    var status: Int?
    var createTime: String?
    var modifyTime: String?
    var skuId: String?//跳转链接
    var skuName: String?//商品描述
    var saleNum: Int = 0//销量
    var price: String?//价格
    var index: Int = 0
}

//点赞返回
class HomeVideoZan: BaseModel {
    var data: HomeVideoZanModel?///点赞返回
}

class HomeVideoZanModel: BaseInitModel {
    var isLiked: Int? //是否点过赞  0：未点过，1：点过
    var likeNum: String? //喜欢数
}

//视频广告信息
class AdVideoModelData: BaseModel {
    var data: AdVideoModel?///点赞返回
}

class AdVideoModel: BaseInitModel {
    var id: String?
    var videoId: String?
    var iosUrl: String?
    var appName: String?
    var advertisementType: Int?  //类型（0 软件推广  1 h5落地页）
    var h5Url: String?
    var advertiserId: String?
}
