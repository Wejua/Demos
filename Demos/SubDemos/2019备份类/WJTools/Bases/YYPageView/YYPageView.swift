//
//  YYPageView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/10/8.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYPageView: UIView {
    //MARK: - lazy properties
    private(set) lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        return view
    }()
    
    //MARK: - life functions
    init(frame: CGRect, segmentView: YYSegmentView?, views: [UIView]) {
        #if DEBUG
        if segmentView != nil {
            assert(segmentView!.buttons.count == views.count, "segmentView中item的个数应该和pageView中view个数相等")
        }
        #endif
        self.currentIndex = segmentView?.selectedIndex ?? 0
        if self.currentIndex != 0 {
            shouldSetupInitialContentOffset = true
        }
        super.init(frame: frame)
        self.segmentView = segmentView
        segmentView?.pageView = self
        self.views = views
        self.addSubview(collectionView)
    }
    
    init(frame: CGRect, segmentView: YYSegmentView?) {
        self.currentIndex = segmentView?.selectedIndex ?? 0
        if self.currentIndex != 0 {
            shouldSetupInitialContentOffset = true
        }
        super.init(frame: frame)
        self.segmentView = segmentView
        segmentView?.pageView = self
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        layout.itemSize = collectionView.bounds.size
        if (shouldSetupInitialContentOffset) {
            self.setCurrentIndex(index: self.currentIndex, animated: false)
        }
    }
    //解决左边缘pop失效问题
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.x < 25 {
            return false
        } else {
            return super.point(inside: point, with: event)
        }
    }
    
    //MARK: - public functions
    func setCurrentIndex(index: Int, animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: animated)
        noScroll = true
        self.currentIndex = index
    }
    
    //MARK: - other properties
    private(set) var segmentView: YYSegmentView?
    
    /// 使用init(frame: CGRect, segmentView: YYSegmentView?, views: [UIView])初始化才有值
    private(set) var views: [UIView]?
    
    weak var dataSource: YYPageViewDataSource?
    
    weak var delegate: YYPageViewDelegate?
    
    private var noScroll: Bool = false//防止两次调用scrollToItem，以第二次为准，而没有动画
    
    private var shouldSetupInitialContentOffset: Bool = false
    
    var currentIndex: Int {
        didSet {
            if currentIndex == oldValue {return}//这句可以防止循环调用
            if noScroll == false {
                collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
            } else {
                noScroll = false
            }
            delegate?.YYPageViewDidScorllToPage?(page: currentIndex, pageView: self)
            segmentView?.selectedIndex = currentIndex
        }
    }
    
}
//MARK: -private functions
extension YYPageView {
    
    private func getPageCount() -> Int {
        if dataSource != nil {
            return dataSource!.numberOfPages(pageView: self)
        } else {
            return views?.count ?? 0
        }
    }
}

//MARK: - UICollectionViewDataSource, delegate
extension YYPageView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPageCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        cell.contentView.subviews.forEach { (subV) in
            subV.removeFromSuperview()
        }
        var view: UIView
        if dataSource != nil {
            view = dataSource!.pageForIndex(index: indexPath.row, pageView: self)
        } else {
            view = views![indexPath.row]
        }
        cell.contentView.addSubview(view)
        view.frame = cell.contentView.bounds
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
//        let direction: Int = translation.x > 0 ? -1 : 1
//        let nextPage: Int = direction > 0 ? currentIndex + 1 : currentIndex - 1
//        var progress: CGFloat = 0
//        if direction == 1 {
//            let value = scrollView.contentOffset.x.truncatingRemainder(dividingBy: self.bounds.width) / self.bounds.width
//            if value != 0 {
//                progress = value
//            }
//        } else {
//            let value = scrollView.contentOffset.x.truncatingRemainder(dividingBy: self.bounds.width) / self.bounds.width
//            if value != 0 {
//                progress = 1.0 - value
//            }
//        }
//        let complete = nextPage - direction != currentIndex
//        delegate?.dragingToPage(nextPage: nextPage, progress: progress, direction: direction, success: complete)
//        //翻页信息传递给segmentView
//        segmentView?.YYPageViewIsPaging(nextPage: nextPage, progress: progress, direction: direction, success: complete)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / self.bounds.width
        if value < 0 {
            currentIndex = 0
        } else if value >= CGFloat(getPageCount()) {
            currentIndex = getPageCount() - 1
        } else {
            currentIndex = Int(value)
        }
    }
    
}

protocol YYPageViewDataSource: NSObjectProtocol {
    func numberOfPages(pageView: YYPageView) -> Int
    func pageForIndex(index: Int, pageView: YYPageView) -> UIView
}

@objc protocol YYPageViewDelegate: NSObjectProtocol {
    
    /// 正在拖拽
    ///
    /// - Parameters:
    ///   - nextPage: 即将显示的下一个页面。不循环的情况下，如果是第一个页面往index递减方向拖拽，值为-1。反之为最大index值+1。这两个情况注意数组越界。
    ///   - progress: 值从0.01...到0.99...停下时变为0，如果为零，可能是到了下一页，或者拖动一点点又回到了原地
    ///   - direction: 有两个可能值，-1：index递减方向；1：index递增方向
    @objc optional func dragingToPage(nextPage: Int, progress: CGFloat, direction: Int, success: Bool)
    
    @objc optional func YYPageViewDidScorllToPage(page: Int, pageView: YYPageView)
}
