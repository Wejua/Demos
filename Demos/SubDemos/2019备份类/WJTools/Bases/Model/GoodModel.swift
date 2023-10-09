//
//  GoodModel.swift
//  YYVideo
//
//  Created by changning on 2019/10/24.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class GoodModel: BaseModel {
    
}

class AddressModel : BaseModel{
    var data : [AddressDetailModel]?
}
class AddressDetailModel : BaseInitModel{
    var id : String?
    var customerId : String?
    var name : String?
    var phone : String?
    var originPhone : String?
    var mobile : String?
    var originMobile : String?
    var zipCode : String?
    var address : String?
    var detailAddress : String?
    var provinceId :String?
    var cityId : String?
    var delFlag : Int?
    var isDefault : Int?
    var countryId : String?
    var createTime : String?
    var delTime : String?
    var updateTime : String?
}

class WalletModel : BaseModel{
    var data : WalletDetailModel?
}
class WalletDetailModel : BaseInitModel{
    var commissionTotal : String?
    var commissionWithdrawTotal : String?
    var commission : String?
    var commissionBlocked : String?
    var shopGainsTotal : String?
    var shopGainsBlocked : String?
    var isAuthentication : String?
    var isBindAlipay : String?
    var alipayAccount : String?
    var alipayRealname : String?
    var cardid : String?
    var relename : String = ""
    var commissionUpdateTime : String?
    var commissionBlockedUpdateTime : String?
    var shopGainsBlockUpdateTime : String?
    var shopGainsTotalUpdateTime : String?
    var authenticationTime : String?
    var alipayBindTime : String?
    var commissionWithdrawBlocked : String?
    var isPayPasswordValidate : String?
}
class WalletAccountModel: BaseModel{
    var data: WalletAccountListModel?
}
class WalletAccountListModel: BaseInitModel{
    var income: String?
    var expend: String?
    var data: [WalletAccountDetailModel]?
}
class WalletAccountDetailModel: BaseInitModel{
    var id: String?
    var changeMoney: String?
    var remark: String?
    var createTime: String?
    var ptype: String?
    var rtype: String?
    var recordsNum: String?
}
class BindModel: BaseModel{
    var data: BindDetailModel?
}
class BindDetailModel: BaseInitModel{
    var code: Int?
    var msg: String?
    var data: String?
}
class IncomeModel: BaseModel{
    var data: IncomeDetailModel?
}
class IncomeDetailModel: BaseInitModel{
    var inComeYesterday: String?
    var inComeSum: String = ""
}
