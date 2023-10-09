//
//  YYCollectionViewTemplate.swift
//  YYVideo
//
//  Created by zhouweijie on 11/9/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
import MBProgressHUD

class YYCollectionViewTemplate<ModelType: YYBaseModel, cellType: YYCollectionViewCellTemplate<ModelType>>: UIView, UICollectionViewDataSource {
    //MARK: - 懒加载属性
    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: YYRelatedProductCell.itemWidth, height: YYRelatedProductCell.itemHeight)
        layout.minimumLineSpacing = YYRelatedProductCell.minimumLineSpacing
        layout.minimumInteritemSpacing = YYRelatedProductCell.minimumInteritemSpacing
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private(set) lazy var collectionV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.allowsMultipleSelection = true
        view.dataSource = self
        view.register(cellType.self, forCellWithReuseIdentifier: NSStringFromClass(cellType.self))
        view.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.loadData(isLoadMore: false)
        })
        view.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.loadData(isLoadMore: true)
        })
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    lazy var noDataView: YYNoDataView = {
        let view = YYNoDataView()
        view.isHidden = true
        return view
    }()
    
    //MARK: - 私有方法
    
    //MARK: - 生命周期方法
    init(frame: CGRect, requester: YYPagedRequester) {
        self.requester = requester
        super.init(frame: frame)
        self.addSubview(collectionV)
        self.collectionV.addSubview(noDataView)
        hud = ProgressHUD.showInView(collectionV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 重写方法
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionV.frame = self.bounds
        noDataView.frame = collectionV.bounds
    }
    
    //MARK: - 其它属性
    private(set) var hud: MBProgressHUD!
    
    private(set) var requester: YYPagedRequester
    
    var willRefreshModel: ((_ newModel: YYPagedModel<ModelType>?, _ oldModel: YYPagedModel<ModelType>?) -> Void)?
    
    ///返回数据对应的模型
    private(set) var model: YYPagedModel<ModelType>?
    
    private(set) lazy var currentPage: Int = beginPage
    
    private(set) lazy var beginPage: Int = requester.currentPage
    
    //MARK: - 公有方法
    func loadData(isLoadMore: Bool) {
        if isLoadMore {
            if currentPage < model?.totalPage ?? -1 {
                currentPage += 1
                requester.currentPage = self.currentPage
                requester.request(model: YYPagedModel<ModelType>.self, encoding: requester.encoding, isArrayData: requester.isArrayData, completion: { (error, model, response) in
                    if error == nil, model != nil {
                        defer {
                            if self.currentPage == model?.totalPage {
                                self.collectionV.mj_footer?.endRefreshingWithNoMoreData()
                            } else {
                                self.collectionV.mj_footer?.endRefreshing()
                            }
                        }
                        guard model?.rows?.count ?? 0 > 0 else {return}
                        guard self.model?.rows?.count ?? 0 > 0 else {return}
                        let beginIndex = self.model!.rows!.count
                        let indexPaths = model!.rows!.indices.map{IndexPath(row: $0 + beginIndex, section: 0)}
                        self.collectionV.performBatchUpdates({
                            self.model?.rows?.append(contentsOf: model!.rows!)
                            self.collectionV.insertItems(at: indexPaths)
                        }, completion: nil)
                    }
                })
            } else {
                ///已到达最后一页
                self.collectionV.mj_footer.endRefreshingWithNoMoreData()
            }
        } else {
            requester.currentPage = self.beginPage
            requester.request(model: YYPagedModel<ModelType>.self, encoding: requester.encoding, isArrayData: requester.isArrayData, completion: { (error, model, response) in
                if error == nil, model != nil {
                    self.setupInitialData(model: model)
                    self.currentPage = self.beginPage
                    if self.currentPage == (model?.totalPage ?? 1) - 1 {
                        self.collectionV.mj_footer.endRefreshingWithNoMoreData()
                    } else {
                        self.collectionV.mj_footer.resetNoMoreData()
                    }
                }
                self.collectionV.mj_header?.endRefreshing()
                self.hud.hide(animated: false)
            })
        }
    }
    
    func setupInitialData(model: YYPagedModel<ModelType>?) {
        self.willRefreshModel?(model, self.model)
        self.model = model
        self.collectionV.reloadData()
        self.collectionV.mj_header?.endRefreshing()
        if self.currentPage == model?.totalPage {
            self.collectionV.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
    //MARK: - collectionView数据源
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model?.rows?.count ?? 0 == 0 {
            self.noDataView.isHidden = false
            return 0
        } else {
            self.noDataView.isHidden = true
            if model!.rows!.count == 1 {//一个cell时左对齐
                collectionView.contentInset = UIEdgeInsets(top: 0, left: YYRelatedProductCell.insetLeft, bottom: 0, right: YYRelatedProductCell.insetLeft + YYRelatedProductCell.itemWidth + YYRelatedProductCell.minimumInteritemSpacing)
            } else {
                collectionView.contentInset = UIEdgeInsets(top: 0, left: YYRelatedProductCell.insetLeft, bottom: 0, right: YYRelatedProductCell.insetLeft)
            }
            return model!.rows!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellType.self), for: indexPath) as! cellType
        cell.model = self.model?.rows?[indexPath.row]
        return cell
    }
}
