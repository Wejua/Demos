//
//  DMModel.swift
//  HttpRequest
//
//  Created by 易金 on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//  rankList的model

import Foundation
import HandyJSON
class  LoginModel: BaseModel {
    var data:dataL?
}

class dataL : BaseModel {
    var yipaiId: String?
    var mobile: String?
    var identify: String?//用户种类
    var level: String?//等级
    var nickName: String?
    var headPic: String?//头像
    var gender: String?//性别
    var age: String?//年龄
    var location: String?//位置
    var sign: String?//个性签名
    var videoZanNum:String?
    var videoNum:String?
    var fanNum:String?
    var attentionNum:String?
    var videoBeZanNumber:String?
}

