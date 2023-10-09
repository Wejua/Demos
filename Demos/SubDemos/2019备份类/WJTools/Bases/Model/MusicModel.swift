//
//  YYMusicListModel.swift
//  YYVideo
//
//  Created by 张永超 on 2018/8/24.
//  Copyright © 2018年 杨凯. All rights reserved.
//

import Foundation
import HandyJSON

/// 音乐类型
class MusicTypeListModel: BaseModel {
    var data: [MusicTypeModel]?
}

class MusicTypeModel: BaseInitModel {
    var id: Int?
    var name: String?
    var status: String?
    var icon: String?
}

/// 音乐列表
class MusicListModel: BaseModel {
    var data: MusicListDataModel?
}

class MusicListDataModel: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: Int?
    var totalPage: Int?
    var havePre: String?
    var haveNext: String?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [MusicDetailModel]?
}

/// 音乐详情
class MusicDetailModel: BaseInitModel {
    var id: String?
    var name: String?
    var author: String?
    var url: String?
    var length: Double?
    var coverUrl: String?
    var yipaiId: String?
    var uploadTime: String?
    var cancelTime: String?
    var status: Int?  //1：正常 其他值如果使用音乐需要提示不能使用
    var createTime: String?
    var modifyTime: String?
    var lyric: String?
    var useNumber: String?
    var hightCell:Int?
    var isCollected: Int? // 0:未收藏 1:已收藏
    
    ///音乐所属用户ID
    var musicYipaiId : String?
    ///音乐所属用户吗名字
    var musicNickName : String?
    ///音乐所属用户头像
    var musicUserHeadPic : String?
    ///用户昵称
    var nickName : String?
    ///所属视频ID
    var videoID:String?
    
    
}

/// 话题列表
class RecordTopicListModel: BaseModel {
    var data: RecordTopicListModelData?
}

class RecordTopicListModelData: BaseInitModel {
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
    var rows: [TopicModel]?
}

/// 收藏&取消
class MusicCollected: BaseModel {
    var data: MusicCollectedDetail?
}

class MusicCollectedDetail: BaseInitModel {
    /// 0:收藏 1:取消
    var isCollected: Int?
}

/// 原曲详情
class OriginalDetailModel: BaseModel {
    var data: MusicDetailModel?
}
