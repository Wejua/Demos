//
//  YYVideoComplaintRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYVideoComplaintRequester: YYRequester {
    
    var videoId: String
    
    var complaintedId: String
    
    init(videoId: String, complaintedId: String) {
        self.videoId = videoId
        self.complaintedId = complaintedId
    }

    override func url() -> String {
        return "/homepage/homePageNewAPI/complaintVideo"
    }
    
    override func parameters() -> [String : Any]? {
        return ["yipaiId":getyipaiId(), "videoId":videoId, "complaintId":complaintedId]
    }
    
}
