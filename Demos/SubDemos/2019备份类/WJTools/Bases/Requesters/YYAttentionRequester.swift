//
//  YYAttentionRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

/// 关注接口
class YYAttentionRequester: YYRequester {
    
    var attentionedId: String
    
    var hasAttentioned: Bool
    
    init(hasAttentioned: Bool, attentionedId: String) {
        self.hasAttentioned = hasAttentioned
        self.attentionedId = attentionedId
    }

    override func url() -> String {
        return "/homepage/homePageNewAPI/attention"
    }
    
    override func parameters() -> [String : Any]? {
        return ["yipaiId": getyipaiId(), "attentionStatus": hasAttentioned, "beYipaiId": attentionedId]
    }
}
