//
//  WJPageView.swift
//  WJPageViewControllerDemo
//
//  Created by zhouweijie on 2019/4/10.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class WJPageView: UIView {
    var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    var collectionView: UICollectionView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.isPagingEnabled = true
//        collectionView.delegate = self
//        collectionView.dataSource = self
        super.init(frame: frame)
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension WJPageView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return buttons.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionViewFlowLayout.scrollDirection {
//        case .horizontal:
//            return CGSize(width: <#T##CGFloat#>, height: defaultHeight)
//        case .vertical:
//            return CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//            
//        }
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//    }
//}
