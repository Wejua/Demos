//
//  YYTableViewTemplate.swift
//  YYVideo
//
//  Created by zhouweijie on 11/12/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

//class YYTableViewTemplate<ModelType: YYBaseModel, cellType: YYCollectionViewCellTemplate<ModelType>>: UIView, UITableViewDataSource {
//    //MARK: - 懒加载属性
//    private(set) lazy var tableView: UITableView = {
//        let tableV = UITableView()
//        tableV.dataSource = self
//        tableV.separatorStyle = .none
//        tableV.rowHeight = <#238#>
//        tableV.estimatedRowHeight = <#0#>
//        tableV.register(<#HomeMyFoucsTableViewCell#>.self, forCellReuseIdentifier: NSStringFromClass(<#HomeMyFoucsTableViewCell#>.self))
//        return tableV
//    }()
//    
//    //MARK: - 私有方法
//    
//    //MARK: - 生命周期方法
//    init(frame: CGRect, requester: YYPagedRequester) {
//        self.requester = requester
//        super.init(frame: frame)
//        self.addSubview(collectionV)
//        hud = ProgressHUD.showInView(collectionV)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - 重写方法
//    
//    //MARK: - 其它属性
//    
//    //MARK: - 公有方法
//    
//    //MARK: - UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return <#20#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(<#YYGoodsTableViewCell#>.self), for: indexPath) as! <#YYGoodsTableViewCell#>
//        <#cell.model =#>
//        return cell
//    }
//}
