//
//  YYVideoZanRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
/// 视频点赞接口
class YYVideoZanRequester: YYRequester {
    
    var videoId: String
    
    var zanStatus: Bool
    
    init(videoId: String, zanStatus: Bool) {
        self.videoId = videoId
        self.zanStatus = zanStatus
    }
    
    override func url() -> String {
        return "/homepage/homePageNewAPI/videoZan"
    }
    
    override func parameters() -> [String : Any]? {
        return ["yipaiId": getyipaiId(), "videoId": self.videoId, "zanStatus": zanStatus]
    }
    
}
