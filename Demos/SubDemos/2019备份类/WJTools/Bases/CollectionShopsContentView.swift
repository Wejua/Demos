//
//  CollectionShopsContentView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/27.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class CollectionShopsContentView: CollectionBatchDeleteView<MyCollectionShopModel, CollectionShopCell> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableV.tableFooterView = UIView()
        tableV.requester = YYDianPuRequester(currentPage: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
