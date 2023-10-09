//
//  MeiSheModel.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/10/24.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit
import HandyJSON


class MeiSheListModel: BaseInitModel {
    var list: [MeiSheModel]?
    var errNo: Bool?
    var hasNext: Bool?
    var errString: String?
}

class MeiSheModel: BaseInitModel {
    var category: Int?
    var coverUrl: String?
    var desc: String?
    var id: String?
    var minAppVersion: String?
    var name: String?
    var packageSize: Double?
    var packageUrl: String?
    var supportedAspectRatio: Int?
    var tags: String?
    var version: Int?
}
