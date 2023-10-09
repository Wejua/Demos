//
//  YYTableView.swift
//  YYVideo
//
//  Created by zhouweijie on 11/4/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
import MBProgressHUD

class YYTableView<ModelType: YYBaseModel, CellType: YYBaseTableViewCell<ModelType>>: UITableView, UITableViewDataSource {
    //MARK: - 懒加载属性
    lazy var noDataView: YYNoDataView = {
        let view = YYNoDataView()
        view.isHidden = true
        return view
    }()
    
    //MARK: - 私有方法
    
    //MARK: - 生命周期方法
    init(frame: CGRect, style: UITableView.Style, requester: YYPagedRequester) {
        self.requester = requester
        super.init(frame: frame, style: style)
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.loadData(isLoadMore: false)
        })
        self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.loadData(isLoadMore: true)
        })
        self.register(CellType.self, forCellReuseIdentifier: NSStringFromClass(CellType.self))
        self.contentInsetAdjustmentBehavior = .never
        self.dataSource = self
        self.addSubview(noDataView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 重写方法
    override func layoutSubviews() {
        super.layoutSubviews()
        if noDataView.frame == .zero {
            noDataView.frame = self.bounds
        }
    }
    
    //MARK: - 其它属性
    
    ///返回数据对应的模型
    private(set) var model: YYPagedModel<ModelType>?
    
    private(set) lazy var currentPage: Int = beginPage
    
    private(set) lazy var beginPage: Int = requester.currentPage
    
    var requester: YYPagedRequester {
        didSet {
            beginPage = requester.currentPage
        }
    }

    
    //MARK: - 公有方法
    /// beginPage：老接口1为第一页，新街口0为第一页
    func loadData(isLoadMore: Bool) {
        if isLoadMore {
            guard model != nil else {return}
            if currentPage < model!.totalPage {
                currentPage += 1
                requester.currentPage = self.currentPage
                requester.request(model: YYPagedModel<ModelType>.self, encoding: requester.encoding, isArrayData: requester.isArrayData) { (error, model, response) in
                    if error == nil, model != nil {
                        defer {
                            if self.currentPage == model!.totalPage {
                                self.mj_footer.endRefreshingWithNoMoreData()
                            } else {
                                self.mj_footer.endRefreshing()
                            }
                        }
                        guard model?.rows?.count ?? 0 > 0 else {return}
                        guard self.model?.rows?.count ?? 0 > 0 else {return}
                        let beginIndex = self.model!.rows!.count
                        let indexPaths = model!.rows!.indices.map{IndexPath(row: $0 + beginIndex, section: 0)}
                        self.performBatchUpdates({
                            self.model?.rows?.append(contentsOf: model!.rows!)
                            self.insertRows(at: indexPaths, with: UITableView.RowAnimation.automatic)
                        }, completion: nil)
                    }
                    self.mj_footer.endRefreshing()
                }
            } else {
                ///已到达最后一页
                self.mj_footer.endRefreshingWithNoMoreData()
            }
        } else {
            requester.currentPage = self.beginPage
            requester.request(model: YYPagedModel<ModelType>.self, encoding: requester.encoding, isArrayData: requester.isArrayData) { (error, model, response) in
                if error == nil, model != nil {
                    self.setupInitialData(model: model)
                    if self.currentPage == model!.totalPage {
                        self.mj_footer.endRefreshingWithNoMoreData()
                    } else {
                        self.mj_footer.resetNoMoreData()
                    }
                }
                self.mj_header?.endRefreshing()
            }
        }
    }
    
    ///不请求数据，直接使用现成数据
    func setupInitialData(model: YYPagedModel<ModelType>?) {
        self.model = model
        self.reloadData()
        self.mj_header?.endRefreshing()
        if model?.currentPage == model?.totalPage {
            self.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    var didDequeueCellBlock: ((ModelType, CellType, IndexPath, UITableView) -> Void)?
    
    var willSetModelBlock: ((ModelType, CellType, IndexPath, UITableView) -> Void)?
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model?.rows?.count ?? 0 == 0 {
            self.noDataView.isHidden = false
            return 0
        } else {
            self.noDataView.isHidden = true
            return model!.rows!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CellType.self), for: indexPath) as! CellType
        guard let model = self.model?.rows?[indexPath.row] else {return cell}
        willSetModelBlock?(model, cell, indexPath, tableView)
        cell.model = model
        didDequeueCellBlock?(model, cell, indexPath, tableView)
        return cell
    }
}
