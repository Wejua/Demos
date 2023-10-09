//
//  CommnetModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/9/3.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit

/// 评论数量
class CommnetCountModel: BaseModel {
    var data: CommnetCountDetal?
}

class CommnetCountDetal: BaseInitModel {
    var commNum: String?
}

/// 评论列表
class CommnetListModel: BaseModel {
    var data: CommnetListModelData?
}

class CommnetListModelData: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: String?
    var totalPage: Int?
    var havePre: Bool?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [CommnetModel]?
}
///评论的model
class CommnetModel: BaseInitModel {
    var id: String?
    ///身份标识
    var identify: String?
    
    var content: String?
    
    var yipaiId: String?
    
    var nickName: String?
    
    var headPic: String?
    
    var videoId: String?
    ///状态 2 3 5时说明已删除
    var status: Int?
    ///父评论id
    var commentTime: String?
    ///点赞状态
    var zanStatus: Int?
    //点赞数量
    var zanNum: String?
    ///
    var parentId: String?
    //父评论
    var parentComment: CommnetModel?
    
    //MARK: - 新评论使用
    ///父回复id
    var parentReplyId: String?
    ///子评论
    var sonComment: CommnetListModelData?
    ///是否展示收回按钮
    var showRecoverBtn: Bool = false
}
    

/// 评论点赞
class CommnetZanModel: BaseModel {
    var data: CommnetZanModelDetal?
}

class CommnetZanModelDetal: BaseInitModel {
    var zanNum: String?
    /// 点赞状态 0是点赞， 1是取消点赞
    var zanStatus: Int?
}

/// 添加评论
class AddCommnetModelData: BaseModel {
    var data: AddCommnetModel?
}

class AddCommnetModel: BaseInitModel {
    var comment: CommnetModel?
    var videoCommentNum: String?
}
