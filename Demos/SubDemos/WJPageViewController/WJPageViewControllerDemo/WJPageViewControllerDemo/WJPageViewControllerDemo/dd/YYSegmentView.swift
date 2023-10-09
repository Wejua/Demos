//
//  YYSegmentView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/30.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

protocol YYSegmentViewDelegate: NSObjectProtocol {
    
}

class YYSegmentView: UIView {
    //MARK: - lazy properties
    private(set) lazy var collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 30, height: 30)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.white
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(YYSegmentButtonCell.self, forCellWithReuseIdentifier: NSStringFromClass(YYSegmentButtonCell.self))
        return view
    }()
    
    //MARK: - life functions
    init(frame: CGRect, selectedIndex: Int, titles: [String]) {
        self.selectedIndex = selectedIndex
        self.titles = titles
        super.init(frame: frame)
        
        self.addSubview(collectionV)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            collectionV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            collectionV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public functions
    
    
    //MARK: - other properties
    weak var delegate: YYSegmentViewDelegate?
    
    var selectedIndex: Int
    
    private(set) var titles: [String]
    
}
//MARK: -private functions
extension YYSegmentView {
    
}
//MARK: - UICollectionViewDataSource, delegate
extension YYSegmentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(YYSegmentButtonCell.self), for: indexPath) as! YYSegmentButtonCell
        cell.titleButton.setTitle(titles[indexPath.row], for: .normal)
        if self.selectedIndex == indexPath.row {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.left)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedIndex == indexPath.row {return}
        let selectedCellIndex = collectionView.indexPathsForSelectedItems![0]
        collectionView.deselectItem(at: selectedCellIndex, animated: false)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.left)
        self.selectedIndex = indexPath.row
    }
    
}
