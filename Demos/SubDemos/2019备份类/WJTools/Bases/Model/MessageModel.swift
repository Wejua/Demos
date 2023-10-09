//
//  MessageModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/9/2.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit
import HandyJSON

//小助手未读
class MessageTopNewsModel: BaseModel {
    var data: MessageTopNewsModelData?
}

class MessageTopNewsModelData: BaseInitModel {
    var total: Int?
    var fansCount : Int?
    var zanCount : Int?
    var commentCount : Int?
    var data: MessageTopModel?
}

//小助手已读
class MessageTopReadModel: BaseModel {
    var data: MessageTopReadModelData?
}

class MessageTopReadModelData: BaseInitModel {
    
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
    var rows: [MessageTopModel]?
}

class MessageTopModel: BaseInitModel {
    var createTime: String? //发布时间
    var topicId: String? //话题ID
    var id: String?
    var title: String? //话题的标题
    var content: String? //消息话题内容
    var status: Int? //消息状态 0,未读 1已读
    var adminPic: String? //发布者头像
}

//系统未读
class MessageSystemNewsModel: BaseModel {
    var data: MessageSystemNewsModelData?
}

class MessageSystemNewsModelData: BaseInitModel {
    var total: Int?
    var data: MessageSystemModel?
}

//系统已读
class MessageSystemReadModel: BaseModel {
    var data: MessageSystemReadModelData?
}

class MessageSystemReadModelData: BaseInitModel {
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
    var rows: [MessageSystemModel]?
}

class MessageSystemModel: BaseInitModel {
    var id: String? //系统ID
    var yipaiId: String? //壹拍ID
    var adminUserName: String? //发布者名字
    var adminPic: String? //发布者头像
    var status: Bool? //消息状态 0,未读 1已读
    var messageTime: String? //发布时间
    var title: String? //系统消息标题
    var messageContent: String? //系统消息内容
}

//粉丝未读
class MessageFansNewsModel: BaseModel {
    var data: MessageFansNewsModelData?
}

class MessageFansNewsModelData: BaseInitModel {
    var total: Int?
    var data: [MessageFansModel]?
}

//粉丝已读
class MessageFansReadModel: BaseModel {
    var data: MessageFansReadModelData?
}

class MessageFansReadModelData: BaseInitModel {
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
    var rows: [MessageFansModel]?
}

class MessageFansModel: BaseInitModel {
    var identify: String? //身份标识
    var yipaiId: String? //关注人的壹拍id
    var nickName: String? //粉丝名称
    var attentionTime: String? //关注时间
    var beYipaiId: String? //被关注人的壹拍id
    var fansHeadPic: String? //粉丝头像
    var messageContent: String? //消息内容
    var status: Bool? //消息状态 0.未读 1.已读
    var attentionStatus: Int? //0我单向关注别人 1别人单向关注我 2相互关注 3相互不关注
}

//赞未读
class MessageZanNewsModel: BaseModel {
    var data: MessageZanNewsModelData?
}

class MessageZanNewsModelData: BaseInitModel {
    var total: Int?
    var data: [MessageZanModel]?
}

//赞已读
class MessageZanReadModel: BaseModel {
    var data: MessageZanReadModelData?
}

class MessageZanReadModelData: BaseInitModel {
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
    var rows: [MessageZanModel]?
}

class MessageZanModel: BaseInitModel {
    var identify: String? //身份标识
    var messageTime: String? //消息时间（赞或评论时间）
    var nickName: String? //赞或评论人昵称
    var commendId: String? //评论ID
    var videoId: String? //视频ID
    var commentContent: String? //评论内容
    var recipientYipaiId: String? //消息接收人ID
    var headPic: String? //赞或评论人头像
    var videoPic: String? //视频封面
    var zanType: Int? //赞的类型 0.视频点赞 1.评论点赞
    var sponsorYipaiId: String? //消息发起人ID
    var commentType: Int? //评论的类型 0 评论视频 1 评论评论
    var zanCommentStatus: Int? //赞或评论区分标识  0、赞 1、评论
    var messageContent: String? //消息内容
    var status: Bool? //消息状态 0.未读 1.已读
}

//评论未读
class MessageCommnetNewsModel: BaseModel {
    var data: MessageCommnetNewsModelData?
}

class MessageCommnetNewsModelData: BaseInitModel {
    var total: Int?
    var data: [MessageCommnetModel]?
}

//评论已读
class MessageCommnetReadModel: BaseModel {
    var data: MessageCommnetReadModelData?
}

class MessageCommnetReadModelData: BaseInitModel {
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
    var rows: [MessageCommnetModel]?
}

class MessageCommnetModel: BaseInitModel {
    var identify: String? //身份标识
    var recipientYipaiId: String? //消息接收人ID
    var sponsorYipaiId: String? //消息发起人ID
    var headPic: String? //评论人头像
    var nickName: String? //评论人昵称
    var messageContent: String? //消息内容
    var messageTime: String? //消息时间（评论时间）
    var videoPic: String? //视频封面
    var commentContent: String? //评论内容
    var videoId: String? //视频ID
    var commendId: String? //评论ID
    var zanType: Int? //赞或评论区分标识  0、赞 1、评论
    var commentType: Int? //评论的类型 0 评论视频 1 评论评论
    var zanCommentStatus: Int? //0我单向关注别人 1别人单向关注我 2相互关注 3相互不关注
    var status: Bool? //消息状态 0.未读 1.已读
}
