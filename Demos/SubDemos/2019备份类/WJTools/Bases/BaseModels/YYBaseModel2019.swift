//
//  YYBaseModel2020.swift
//  YYVideo
//
//  Created by zhouweijie on 11/27/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYBaseModel2020<E>: Convertible {
    
    var status: Int = -1
    
    var message: String = ""
    
    var data: E?
    
    required init() {
        
    }
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name
    }
    
    func kj_JSONKey(from property: Property) -> JSONPropertyKey {
        return property.name
    }
    
    func kj_didConvertToModel(from json: [String : Any]) {
        
    }
    
    func kj_didConvertToJSON(json: [String : Any]) {
        
    }
}
