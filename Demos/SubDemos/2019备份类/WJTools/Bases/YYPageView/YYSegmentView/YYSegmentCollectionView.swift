//
//  YYSegmentCollectionView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/10/8.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYSegmentCollectionView: UICollectionView {
    //MARK: - lazy properties
    private(set) lazy var indicator: YYSegmentDefaultIndicator = {
        let image = UIImage.fromColor(color: UIColor(hex: "000000"), size: CGSize(width: 8, height: 3))
        let imageV = YYSegmentDefaultIndicator(image: image)
        if image != nil {
            imageV.layer.cornerRadius = image!.size.height/2.0
            imageV.layer.masksToBounds = true
        }
        return imageV
    }()
    
    //MARK: - life functions
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public functions
    override func reloadData() {
        super.reloadData()
        self.didFinishReloadData?()
    }
    
    //MARK: - other properties
    var didFinishReloadData: (() -> Void)?
    
    var indicatorBottomInset: CGFloat = 0
}


