//
//  WJPageView.swift
//  customButton
//
//  Created by zhouweijie on 2019/1/15.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

protocol WJPageViewDatasource: NSObjectProtocol {
    func segmentCellForIndex(index: NSInteger) -> UICollectionViewCell
    func segmentCellSizeForIndex(index: NSInteger) -> CGSize
    func numberOfPagesInWJPageView() -> NSInteger
    func detailCellForIndex(index: NSInteger) -> UICollectionViewCell
    func detailCellSizeForIndex(index: NSInteger) -> CGSize
}

@objc protocol WJPageViewDelegate: NSObjectProtocol {
    @objc optional func willDisplayPageForIndex(index: NSInteger)
    @objc optional func didEndDisplayPageForIndex(index: NSInteger)
    @objc optional func willTapkPageAtIndex(index: NSInteger, selectedState: Bool)
    @objc optional func didTapPageAtIndex(index: NSInteger)
}

class WJPageView: UIView {
//    struct WJPageViewFlowLayout {
//        var segmentFlowLayout: UICollectionViewFlowLayout
//        var detailFlowLayout: UICollectionViewFlowLayout
//    }
//    private(set) var flowLayout: WJPageViewFlowLayout
    weak var dataSource: WJPageViewDatasource?
    weak var delegate: WJPageViewDelegate?
    var isDetached: Bool = false
    var selectedIndex: Int = 0 {
        didSet {
            self.segmentView?.selectedIndex = selectedIndex
//            self.detailView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
//    private let detailViewCellReuseID = "detailViewCellReuseID"

//    private(set) var views = [UIView]()
    private(set) var segmentView: WJSegmentView?
    private(set) var pageDetailView: WJPageDetailView!
//        = {
//        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout.)
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
//        collectionView.delegate = self
//        collectionView.dataSource = self
////        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: detailViewCellReuseID)
//        return collectionView
//    }()
    
//    private(set) lazy var flowLayout: UICollectionViewFlowLayout = {
//        let flowLayout = UICollectionViewFlowLayout.init()
//        flowLayout.minimumLineSpacing = 20
//        flowLayout.minimumInteritemSpacing = 20
//        flowLayout.scrollDirection = .horizontal
//        return flowLayout
//    }()
    
//    init(flowLayout: WJPageViewFlowLayout) {
//        super.init(frame: .zero)
//        self.flowLayout = flowLayout
//        self.addSubview(self.pageDetailView)
//        if self.segmentView != nil {
//            self.addSubview(self.segmentView!)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

//    init(buttons: [WJButton], views: [UIView]) {
//        self.views = views
//        super.init(frame: .zero)
//        let segmentView = WJSegmentView(buttons: buttons)
//        self.setupPageView(segmentView: segmentView, views: views)
//    }
    
//    init(views: [UIView]) {
//        self.views = views
//        super.init(frame: .zero)
//        self.addSubview(self.detailView)
//    }
    
//    init(detachedSegmentView: WJSegmentView, views: [UIView]) {
//        self.views = views
//        super.init(frame: .zero)
//        self.isDetached = true
//        self.setupPageView(segmentView: detachedSegmentView, views: views)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupPageView(segmentView: WJSegmentView, views: [UIView]) {
//        assert(segmentView.buttons.count == views.count && segmentView.buttons.count != 0 && views.count != 0, "segmentView数和Views数量不等，或者为空")
//        self.segmentView = segmentView
////        self.segmentView!.flowLayout.scrollDirection = self.scrollDirection
//        self.addSubview(self.detailView)
//        self.addSubview(self.segmentView!)
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if self.isDetached || self.segmentView == nil {
//            self.detailView.frame = self.bounds
//        } else {
//            if self.flowLayout.scrollDirection == .horizontal {
//                self.segmentView?.frame = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: (self.segmentView?.intrinsicContentSize.height ?? 0)))
//                let size = CGSize(width: self.bounds.width, height: self.bounds.height-(self.segmentView?.frame.height ?? 0))
//                self.flowLayout.itemSize = size
//                self.detailView.frame = CGRect(origin: CGPoint(x: 0, y: (self.segmentView?.frame.height ?? 0)), size: size)
//            } else {
//                self.segmentView?.frame = CGRect(origin: .zero, size: CGSize(width: (self.segmentView?.intrinsicContentSize.width ?? 0), height: self.bounds.height))
//                let size = CGSize(width: self.bounds.width-(self.segmentView?.frame.width ?? 0), height: self.bounds.height)
//                self.flowLayout.itemSize = size
//                self.detailView.frame = CGRect(origin: CGPoint(x: self.segmentView?.frame.width ?? 0, y: 0), size: size)
//            }
//        }
//    }
    
   
    
    
    private var indicatorMidFrame: CGRect?
}

extension WJPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
