//
//  YYCollectionVideoRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/13/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYCollectionVideoRequester: YYRequester {
    
    var videoId: String
    
    var yipaiId: String
    
    var coverUrl: String
    
    var videoName: String
    
    init(videoId: String, yipaiId: String, coverUrl: String, videoName: String) {
        self.videoId = videoId
        self.yipaiId = yipaiId
        self.coverUrl = coverUrl
        self.videoName = videoName
    }

    override func url() -> String {
        return "/homepage/homePageNewAPI/insertCollect"
    }
    
    override var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    override func parameters() -> [String : Any]? {
        return ["videoId":videoId, "yipaiId":yipaiId, "coverUrl":coverUrl, "videoName":videoName]
    }
    
}
