//
//  WJSegmentView.swift
//  WJPageViewControllerDemo
//
//  Created by zhouweijie on 2019/4/10.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class WJSegmentViewCell: UICollectionViewCell {
    static let reusedID = "WJSegmentViewCellReusedID"
    
    var button: WJButton = {
        let button = WJButton.intrinsicSizeButton(titlePosition: .left, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), contentSpacing: 5)
        button.setTitle("title", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    var indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    var indicatorSize: CGSize = CGSize(width: 20, height: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(button)
        self.contentView.addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false;
        indicator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        indicator.widthAnchor.constraint(equalToConstant: indicatorSize.width)
        indicator.heightAnchor.constraint(equalToConstant: indicatorSize.height)
        indicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
    }
}

class WJSegmentView: UIView {

    var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    var defaultHeight: CGFloat = 50.0
    
    var collectionView: UICollectionView
    
    var buttons = [WJButton]()
    
    override func layoutSubviews() {
         super.layoutSubviews()
        var selfFrame = self.frame
        selfFrame.size.height = self.defaultHeight
        self.frame = selfFrame
        
        collectionView.frame = self.bounds
    }
    
    convenience init(buttons: [WJButton]) {
        self.init(frame: .zero)
        self.buttons = buttons
    }
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(WJSegmentViewCell.self, forCellWithReuseIdentifier: WJSegmentViewCell.reusedID)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        super.init(frame: frame)
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//extension WJSegmentView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
//}
