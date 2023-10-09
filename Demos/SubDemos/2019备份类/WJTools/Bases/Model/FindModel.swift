//
//  FindModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/8/30.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit
import HandyJSON

//Banner
class FindBannerListModel: BaseModel {
    var data: FindBannerListModelData?
//    var data: [FindBannerModel]?
}

class FindBannerListModelData: BaseModel {
    var banners: [FindBannerModel]?
}

class FindBannerModel: BaseInitModel {
    var id: String? //照片id
    var name: String? //名称
    var type: Int? //类型 1：话题中心 2：视频中心 3：音乐中心 4：用户中心 5：H5页面  6：app推广是
    var param: String? //参数
    var pic: String? //图片url
    var yipaiId: String? //创建人
    var advertiserType: Int? //类型（0：没有广告  1：有广告）
    var advertisementId: String? //广告id
    var advertiserId: String?  //广告主id
    
    var iosUrl: String? //app推广ios链接
}

//推荐关注人
class RecommendAttListModel: BaseModel {
    var data: RecommendAttListModelData?
}

class RecommendAttListModelData: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: Int?
    var totalPage: Int?
    var havePre: Bool?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [RecommendAttModel]?
}

class RecommendAttModel: BaseInitModel {
    var yipaiId: String?
    var nickName: String? //昵称
    var seq: String? //序号
    var zanNum: String? //获赞量
    var headPic: String? //头像路径
    var status: Int? //0我单向关注别人 1别人单向关注我 2相互关注 3相互不关注
}

//热搜词
//Banner
class HotSearchListModel: BaseModel {
    var data: [HotSearchModel]?
}

class HotSearchModel: BaseInitModel {
    var id: String? //id
    var seq: String? //序号
    var content: String? //搜索内容
}

//话题列表
class TopicListModel: BaseModel {
    var data: TopicListModelData?
}

class TopicListModelData: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: Int?
    var totalPage: Int?
    var havePre: Bool?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [TopicListRowModel]?
    
    //var rows: [TopicListRow2Model]?
}

class TopicListRowModel: BaseModel {
    var ucvideoVos: [VideoDetailModel]?
    var topic: TopicModel?
}

class VideoActionModel: BaseModel {
    var commentNum: Int?
    var downloadNum: Int?
    var likeNum: Int?
    var loadNum: Int?
    var shareNum: Int?
}


//话题信息详情
class TopicDetailModel: BaseModel {
    var data: TopicModel?
}

class TopicModel: BaseInitModel {
    var id: String? //id
    var title: String? //标题
    var bgPic: String? //背景图片
    var headPic: String? //头像
    var adminUserName: String? //话题发布者
    var status: Int? //状态 0：草稿 1：上线 2：下线
    var seq: String? //话题序号
    var num: String? //话题挑战次数
    var publishTime: String? //发布时间
    var content: String? //话题内容
    
    //TODO: - 2.0可能要用到
    var skipUrl: String?
    var topicType: Int?
}

//话题相关视频信息
class TopicVideoListModel: BaseModel {
    var data: TopicVideoListModelData?
}

class TopicVideoListModelData: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: Int?
    var totalPage: Int?
    var havePre: Bool?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [VideoDetailModel]?
}

//搜索
class SearchResultModel: BaseModel {
    var data: SearchResultModelData?
}

class SearchResultModelData: BaseInitModel {
    var topic: [TopicModel]?
    var video: [VideoDetailModel]?
    var user: [SearchUserModel]?
}


//搜索用户
class SearchUserResultModel: BaseModel {
    var data: [SearchUserModel]?
}

//搜索话题
class SearchTopicResultModel: BaseModel {
    var data: [TopicModel]?
}

//搜索视频
class SearchVideoResultModel: BaseModel {
    var data: [VideoDetailModel]?
}

class SearchUserModel: BaseInitModel {
    var yipaiId: String? //id
    var headPic: String? //头像
    var nickName: String? //名字
    var status: String? //用户状态
    var sign: String? //签名
    var identify :String?
    ///0我单向关注别人 1别人单向关注我 2相互关注 3相互不关注
    var mutualAttentionStatus: Int?
}

//TODO: - 2.0可能要用到
class TopicListRow2Model: BaseModel {
    var appVideoVos: [VideoDetail2Model]?
    var topic: TopicModel?
}

class VideoDetail2Model: BaseModel {
    var isAttentioned: Int?
    var isLiked: Int?
    var musicVo: MusicVoModel?
    var topicVideoVo: TopicVideoVoModel?
    var topicVo: TopicVoModel?
    var userMessage: UserMessageModel?
    var video: VideoModel?
    var videoAction: VideoActionModel?
}

class MusicVoModel: BaseModel {
    var id: String?
    var name: String?
    var author: String?
    var url: String?
    var length: String?
    var coverUrl: String?
    var yipaiId: String?
    var musicNickName: String?
    var musicUserHeadPic: String?
    var useNumber: Int?
}

class TopicVideoVoModel: BaseModel {
    var isExample: Int?
    var topicId: String?
    var videoId: String?
    var yipaiId: String?
    var seq: Int?
}

class TopicVoModel: BaseModel {
    var bgPic: String?
    var id: String?
    var num: Int?
    var title: String?
    var headPic: String?
    var whetherRecommend: String?
    var yipaiId: String?
    var content: String?
    var topicType: String?
    var skipUrl: String?
    var adminUserName: String?
}

class UserMessageModel: BaseModel {
    var yipaiId: String?
    var nickName: String?
    var headPic: String?
    var gender: Int?
    var age: Int?
    var sign: String?
    var identifyId: Int?
    var level: Int?
    var birthday: String?
    var province: String?
    var city: String?
    var district: String?
    var timeType: Int?
}

class VideoModel: BaseModel {
    var coverUrl: String?
    var description: String?
    var fileId: String?
    var firstFrame: String?
    var id: String?
    var length: Int?
    var musicId: String?
    var originalUrl: String?
    var timeSpan: Int?
    var url720: String?
    var width: Int?
    var yipaiId: String?
    var whetherRecommend: Int?
    var title: String?
    var watermark: String?
}
