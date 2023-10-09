//
//  YYPagedModel.swift
//  YYVideo
//
//  Created by zhouweijie on 10/30/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYPagedModel<E>: YYBaseModel {
    /// 当前页
    var currentPage: Int = -1
    /// 每页条数
    var pageSize: Int = -1
    /// 总页数
    var totalPage: Int = -1
    /// 总条数
    var count: Int = -1
    /// 内容数组
    var rows: [E]?
    
    override func kj_modelKey(from property: Property) -> ModelPropertyKey {
        switch property.name {
        case "count":
            return ["count", "recordsNum", "total", "recordsTotal"]
        case "rows":
            return ["rows", "data", "datas"]
        case "totalPage":
            return ["totalPage", "totalPages"]
        default:
            return super.kj_modelKey(from: property)
        }
    }
    
    override func kj_didConvertToModel(from json: [String : Any]) {
        if totalPage == -1 {//新接口没有totalPage字段，自己算
            if (count % pageSize) == 0 {
                totalPage = count/pageSize - 1
            } else {
                totalPage = count/pageSize
            }
        }
    }
  
}
