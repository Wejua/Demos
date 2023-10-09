//
//  YYBaseModel.swift
//  YYVideo
//
//  Created by zhouweijie on 10/30/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYBaseModel: Convertible, HandyJSON {
    
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
