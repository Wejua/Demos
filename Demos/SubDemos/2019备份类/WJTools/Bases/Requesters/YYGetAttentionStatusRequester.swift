//
//  YYGetAttentionStatusRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

/// 获取关注状态
class YYGetAttentionStatusRequester: YYRequester {
    
    var attentionedId: Int
    
    init(attentionedId: Int) {
        self.attentionedId = attentionedId
    }

    override func url() -> String {
        return "/userCenter/ucAttention/mutualAttentionStatus"
    }
    
    override func parameters() -> [String : Any]? {
        return ["myYipaiId": getyipaiId(), "otherYipaiId": "\(attentionedId)"]
    }
    
}
