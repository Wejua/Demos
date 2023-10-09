//
//  YYPagedRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 11/5/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYPagedRequester: YYRequester {
    
    var currentPage: Int
    
    required init(currentPage: Int) {
        self.currentPage = currentPage
        super.init()
    }
    
}
