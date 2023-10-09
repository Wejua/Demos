
//  BaseModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/7/3.
//  Copyright © 2018 杨凯. All rights reserved.
//

import Foundation
import HandyJSON

class BaseInitModel: HandyJSON {
    required init() {
    }
}

class BaseModel: BaseInitModel {
    /*
     1：成功；20：未登录； 21: 封号；
     */
    var status: Int?
    var code: String?
    var message: String?
}

class DefaulModel: BaseModel {
    var data: Any?
}
class MerchantModel: BaseModel{
    var data: String?
}


//area的城市
struct Province: HandyJSON {
    var name: String?
    var cities: [City]?
}

struct City: HandyJSON {
    var name: String?
    var zones: [String]?
}

