//
//  UserModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/7/3.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel: BaseModel {
    var data: UserDetailModel?
}

class UserDetailModel: BaseInitModel {
    var yipaiId: String?
    ///手机号
    var mobile: String?
    ///用户种类
    var identify: String?
    ///等级
    var level: String?
    ///名字
    var nickName: String?
    ///头像
    var headPic: String?
    ///性别
    var gender: String?
    ///生日
    var birth: String?
    ///年龄
    var age: String?
    ///位置
    var location: String?
    ///个性签名
    var sign: String?
    ///视频被赞数量
    var videoBeZanNumber: String?
    ///关注数量
    var attentionNum: String?
    ///粉丝数量
    var fanNum: String?
    ///作品数量
    var videoNum: String?
    ///好友数量
    var friendNum: String?
    ///喜欢视频的数量
    var videoZanNum: String?
    ///状态
    var status: Int? // 0正常 1封禁 2已删除
    //拍摄时长
    var timeType: Int? //0：30秒 1：60秒 2：120秒 3：180秒 5：300秒
    var storeId: String?
    var storeStatus: String?
    var realName: String?
    var isAuthentication: String?
    var isBindAlipay: String?
}

/// 视频列表
class MyVideoListModel: BaseModel {
    var data: MyVideoListDataModel?
}

class MyVideoListDataModel: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: String?
    ///最大页码
    var totalPage: Int?
    var havePre: String?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [VideoDetailModel]?
}


/// 关注结果
class AccountModel: BaseModel {
    var data: AccountStateModel?
}

class AccountStateModel: BaseInitModel {
    ///相互关注状态（0 我单向关注他 1 他单向关注我 2 相互关注 3相互不关注 ）
    var isAttentioned: Int?
}
//收藏结果
class collectModel: BaseModel {
    var data:collectStateModel?
    
}
class collectStateModel: BaseInitModel {
    //0为收藏 1收藏
    var isCollected:String?
    
}
/// 私信
class YYChatModel: NSObject {
    ///内容
    var contentText:String?
    var state:String?
}

/// 账号管理
class AccountChangeModel: BaseModel {
    var data: [StatueModel]?
}

class StatueModel: BaseInitModel {
    var kind: Int?
    var content: String?
    var status: Int?
}

/// 举报
class ReportListModel: BaseModel {
    var data: [ReportModel]?
}

class ReportModel: BaseInitModel {
    var id: Int?
    var name: String?
}

/// 粉丝和关注
class FansAndFriendsListModel: BaseModel {
    var data: FansAndFriendsModelData?
}

class FansAndFriendsModelData: BaseInitModel {
    var currentPage: Int?
    var pageSize: Int?
    var count: Int?
    var totalPage: Int?
    var havePre: String?
    var haveNext: Bool?
    var prePage: Int?
    var nextPage: Int?
    var firstPage: Int?
    var finalPage: Int?
    var rows: [FansAndFriendsModel]?
}

class FansAndFriendsModel: BaseInitModel {
    var yipaiId: String?
    var name: String?
    var nickName:String?
    var identify:String?
    var headPic:String?
    var attentionTime:String?
    var sign:String?
    /// 1:单项关注我 2:双向关注
    var status:Int?
}


/// 账号管理
class PhoneNumListModel: BaseModel {
    var data: [PhoneNumModel]?
}

class PhoneNumModel: BaseInitModel {
    var id: String?
    var country: String?
    var name: String?//用户种类
    var code: String?//等级
    var seq: String?
    var status: String?//头像
    var createTime: String?//性别
    var modifyTime:String?//年龄
}

/// 建议反馈图片上传
class IMageJsonModel: BaseInitModel {
    var status:String?
    var message:String?
    var data:imgUrl?
    
}
class imgUrl: BaseInitModel {
    var url : String?
}

///欢迎广告页
class AdModel: BaseModel {
    var data: AdModelDetail?
}

class AdModelDetail: BaseInitModel {
    var id: String?
    var name: String?
    var time: Int?//显示时间
    var type: String? //链接类型 0.不选择  1.话题  2.视频  4.用户  5.H5页面  app推广是6
    var param: String? //链接参数
    var ios750: String?
    var ios1242: String?
    var ios1125: String?
    var iosUrl: String? //app推广ios链接
    var advertiserType: Int? //类型（0：没有广告  1：有广告）
    var advertisementId: String? //广告id
    var advertiserId: String? //广告主id
}

/// 黑名单列表
class BlackListModel: BaseModel {
    var data: [UserDetailModel]?
}
class AddressProvincesModel: BaseModel{
    var data: [ProvinceDetailModel]?
}
class ProvinceDetailModel : BaseInitModel,Encodable{
    var id: String?
    var name: String?
//    var sort: String?
//    var delFlag: String?
//    var createTime: String?
//    var modifyTime: String?
//    var delTime: String?
    var child: [CityDetailModel]?
}
class CityDetailModel: BaseInitModel,Encodable{
    var id: String?
    var name: String?
    var provinceId: String?
//    var sort: String?
//    var delFlag: String?
//    var createTime: String?
//    var modifyTime: String?
//    var delTime: String?
    var child: [AreaDetailModel]?
}
class AreaDetailModel: BaseInitModel,Encodable{
    var id: String?
    var name: String?
    var cityId: String?
//    var sort: String?
//    var delFlag: String?
//    var createTime: String?
//    var modifyTime: String?
//    var delTime: String?
}
class CategoryModel: BaseModel {
    var data: [CategoryDetailModel]?
}
class CategoryDetailModel: BaseInitModel{
    var id: String?
    var name: String?
    var parentId: String?
    var typeId: String?
    var grade: String?
    var rate: String?
}
class AuthenticateModel: BaseModel{
    var data: AuthenticatrDetailModel?
}
class AuthenticatrDetailModel: BaseInitModel{
    var code: Int?
    var msg: String?
}
class UserAccountInfoModel: BaseModel{
    var data: UserAccountDetailModel?
}
class UserAccountDetailModel: BaseInitModel{
    var mobile: String?
    var isWriteoff: String?//是否申请注销
    var isBindAlipay: String?//是否绑定支付宝
    var isAuthentication: String?//是否实名认证
    var isSetPaypassword: String?//是否设置支付密码
}
class AuthModel: BaseModel{
    var data: AuthDetailModel?
}
class AuthDetailModel: BaseInitModel{
    var isAuthentication: String?
    var authenticationNum: String?
    var cardid: String?
    var realname: String?
    var mobile: String?
    var authenticationTime: String?
}
