//
//  WJPageDetailView.swift
//  WJPageView
//
//  Created by zhouweijie on 2019/3/20.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

@objc protocol WJPageDetailViewDelegate {
    @objc func detailViewDidScroll(detailView: WJPageDetailView, contentOffset: CGPoint, scrollDirection: UICollectionView.ScrollDirection)
}

class WJPageDetailView: UIView {
    
    weak var dataSource: WJPageViewDatasource?
    
    private(set) var collectionView: UICollectionView
    
    init(flowLayout: UICollectionViewFlowLayout) {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        super.init(frame: .zero)
        
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WJPageDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfPagesInWJPageView() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.dataSource?.detailCellForIndex(index: indexPath.row) ?? UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.segmentView == nil {return}
        if self.flowLayout.scrollDirection == .horizontal {
            let offsetX = scrollView.contentOffset.x
            let detailViewWidth = self.detailView.bounds.width
            let defaultFrame: CGRect?
            let fmodfValue = fmodf(Float(offsetX), Float(detailViewWidth))
            if fmodfValue == 0 {
                //翻页完成
                self.segmentView!.selectedItem.indicatorView.isHidden = false
                let index = Int(offsetX/detailViewWidth)
                self.segmentView!.selectedIndex = index
                let selectedItem = self.segmentView!.selectedItem
                defaultFrame = selectedItem!.convert(selectedItem!.indicatorView.frame, to: self.segmentView!.collectionView)
                self.cloneIndicator.frame = defaultFrame ?? .zero
                self.cloneIndicator.backgroundColor = UIColor.red
                self.cloneIndicator.alpha = 0.5
            } else {
                //正在翻页
                self.segmentView!.selectedItem.indicatorView.isHidden = true
                let point = scrollView.panGestureRecognizer.translation(in: self.detailView)
                self.cloneIndicator.backgroundColor = UIColor.orange
                if point.x < 0 {
                    //往右滑
                    let index = Int(offsetX/detailViewWidth)
                    if index == self.segmentView!.items.count - 1 {return}
                    let startItem = self.segmentView!.items[index]
                    let toItem = self.segmentView!.items[index+1]
                    if toItem.window == nil || startItem.window == nil {return}
                    let startFrame = startItem.convert(startItem.indicatorView.frame, to: self.segmentView!.collectionView)
                    let toFrame = toItem.convert(toItem.indicatorView.frame, to: self.segmentView!.collectionView)
                    let indicatorDistance = toFrame.maxX - startFrame.maxX
                    var indicatorOffset = CGFloat(fmodfValue) / detailViewWidth * indicatorDistance * 2
                    var newFrame: CGRect
                    if indicatorOffset < indicatorDistance {
                        //头部到到达目标位置
                        newFrame = CGRect(x: startFrame.minX, y: startFrame.minY, width: startFrame.width+indicatorOffset, height: startFrame.height)
                        indicatorMidFrame = CGRect(x: startFrame.minX, y: startFrame.minY, width: toFrame.maxX - startFrame.minX, height: toFrame.height)
                    } else {
                        //尾部开始收缩
                        let indicatorDistance = toFrame.minX - startFrame.minX
                        indicatorOffset = (CGFloat(fmodfValue) - detailViewWidth / 2) / detailViewWidth * indicatorDistance * 2
                        newFrame = CGRect(x: indicatorMidFrame!.minX + indicatorOffset, y: indicatorMidFrame!.minY, width: indicatorMidFrame!.width - indicatorOffset, height: indicatorMidFrame!.height)
                    }
                    self.cloneIndicator.frame = newFrame
                } else {
                    //往左滑
                    let index = Int(offsetX/detailViewWidth) + 1
                    if offsetX < 0 || index > self.segmentView!.items.count - 1 {return}
                    let startItem = self.segmentView!.items[index]
                    let toItem = self.segmentView!.items[index-1]
                    if toItem.window == nil || startItem.window == nil {return}
                    let startFrame = startItem.convert(startItem.indicatorView.frame, to: self.segmentView!.collectionView)
                    let toFrame = toItem.convert(toItem.indicatorView.frame, to: self.segmentView!.collectionView)
                    let indicatorDistance = startFrame.minX - toFrame.minX
                    let indicatorOffset = (detailViewWidth - CGFloat(fmodfValue)) / detailViewWidth * indicatorDistance * 2
                    let newFrame: CGRect
                    if indicatorOffset < indicatorDistance {
                        newFrame = CGRect(x: startFrame.minX - indicatorOffset, y: startFrame.minY, width: startFrame.width + indicatorOffset, height: startFrame.height)
                        indicatorMidFrame = CGRect(x: toFrame.minX, y: toFrame.minY, width: startFrame.maxX - toFrame.minX, height: toFrame.height)
                    } else {
                        let indicatorDistance = toFrame.maxX - startFrame.maxX
                        let indicatorOffset = (detailViewWidth / 2 - CGFloat(fmodfValue)) / detailViewWidth * indicatorDistance * 2
                        newFrame = CGRect(x: indicatorMidFrame!.minX, y: indicatorMidFrame!.minY, width: indicatorMidFrame!.width + indicatorOffset, height: indicatorMidFrame!.height)
                    }
                    self.cloneIndicator.frame = newFrame
                }
            }
        } else {
            
        }
        
    }

}
