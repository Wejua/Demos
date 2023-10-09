//
//  YYCollectionView.swift
//  YYVideo
//
//  Created by zhouweijie on 11/5/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
import MBProgressHUD

class YYCollectionView<R: YYPagedRequester, Element: YYBaseModel>: UICollectionView {
    //MARK: - 懒加载属性
    
    //MARK: - 私有方法
    
    //MARK: - 生命周期方法
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
//        hud = ProgressHUD.showInView(self)
//        self.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
//            self?.loadData(isLoadMore: false)
//        })
//        self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
//            self?.loadData(isLoadMore: true)
//        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 重写方法
    
    //MARK: - 其它属性
//    private(set) var hud: MBProgressHUD!
    
    ///返回数据对应的模型
    private(set) var model: YYPagedModel<Element>?
    
    private(set) lazy var currentPage = self.beginPage
    
    lazy var beginPage: Int = 0
    
    //MARK: - 公有方法
    func loadData(isLoadMore: Bool) {
        if isLoadMore {
            if currentPage < model?.totalPage ?? 1 {
                currentPage += 1
                R(currentPage: currentPage).request(model: YYPagedModel<Element>.self) { (error, model, response) in
                    if error == nil, model != nil {
                        defer {
                            if self.currentPage == model?.totalPage {
                                self.mj_footer?.endRefreshingWithNoMoreData()
                            } else {
                                self.mj_footer?.endRefreshing()
                            }
                        }
                        guard model?.rows?.count ?? 0 > 0 else {return}
                        guard self.model?.rows?.count ?? 0 > 0 else {return}
                        let beginIndex = self.model!.rows!.count
                        let indexPaths = model!.rows!.indices.map{IndexPath(row: $0 + beginIndex, section: 0)}
                        self.performBatchUpdates({
                            self.model?.rows?.append(contentsOf: model!.rows!)
                            self.insertItems(at: indexPaths)
                        }, completion: nil)
                    }
                }
            }
        } else {
            R(currentPage: beginPage).request(model: YYPagedModel<Element>.self) { (error, model, response) in
                if error == nil, model != nil {
                    self.setupInitialData(model: model)
                }
//                self.hud.hide(animated: false)
            }
        }
    }
    
    func setupInitialData(model: YYPagedModel<Element>?) {
        self.model = model
        self.reloadData()
        self.mj_header?.endRefreshing()
        if self.currentPage == model?.totalPage {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}
