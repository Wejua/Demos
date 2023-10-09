//
//  WJSegmentView.swift
//  news
//
//  Created by zhouweijie on 2018/12/21.
//  Copyright © 2018 malei. All rights reserved.
//

import UIKit

@objc protocol WJSegmentViewDataSource {
    func WJSegmentView(numberOfSectionsInNumberOfSectionsIn segmentView: WJSegmentView) -> NSInteger
    func WJSegmentView(segmentView: WJSegmentView, numberOfRowsInSection section: NSInteger)
    func WJSegmentView(segmentView: WJSegmentView, sizeForItemAtIndexPath indexPath: NSIndexPath)
    @objc optional func indicatorViewInWJSegmentView(segmentView: WJSegmentView) -> UIView
    @objc optional func indicatorSizeInWJSegmentView(segmentView: WJSegmentView) -> CGSize
}

protocol JWSegmentViewDelegate {
    func WJSegmentViewShouldSelectedItem(atIndexPath indexPath: NSIndexPath, segmentView: WJSegmentView)
    func WJSegmentViewDidSelectedItem(atIndexPath indexPath: NSIndexPath, segmentView: WJSegmentView)
    func WJSegmentView()
}


@objcMembers class WJSegmentView: UIView {
    
    //MARK: - public
    var didSelectItem: ((Int) -> Void)?
    
    var didDeselectedItem: ((Int) -> Void)?
    
    var itemForIndex:((UInt) -> SegmentItem?)?
    
//    var itemsAlignLeft: Bool = true
    
    weak var dataSource: AnyObject?
    
    private(set) weak var pageView: WJPageView!
    
    /// 当前选中的index，可修改
    var selectedIndex: Int = 0 {
        didSet {
            if selectedIndex>=0 && selectedIndex<self.items.count {
                if oldValue >= 0 && oldValue < self.items.count && (oldValue != selectedIndex) {
                    self.items[oldValue].isSelected = false
                }
                self.items[selectedIndex].isSelected = true
                self.selectedItem = self.items[selectedIndex]
            }
        }
    }
    
    private(set) var selectedItem: SegmentItem!
    
    private(set) var items = [SegmentItem]()
    
    private(set) var buttons = [WJButton]()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: WJSegmentItemReUsedID)
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private(set) lazy var flowLayout: UICollectionViewFlowLayout = {
        var flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
//    init(items: [SegmentItem]) {
//        super.init(frame: .zero)
//        self.items = items
//        self.addSubview(self.collectionView)
//    }
    
//    init(titles: [String]) {
//        super.init(frame: .zero)
//        var items = [SegmentItem]()
//        for title in titles {
//            let button = WJButton.intrinsicSizeButton(titlePosition: .left, padding: .zero, contentSpacing: 0)
//            button.setTitle(title, for: .normal)
//            items.append(SegmentItem(button: button, indicator: nil))
//        }
//        self.items = items
//        self.addSubview(self.collectionView)
//    }
    
    init(buttons: [WJButton]) {
        super.init(frame: .zero)
        self.buttons = buttons
        var items = [SegmentItem]()
        for button in buttons {
            let item = SegmentItem(button: button, indicator: nil)
//            item.direction = self.flowLayout.scrollDirection
            items.append(item)
        }
        self.items = items
        self.addSubview(self.collectionView)
    }
    
    init(flowLayout: UICollectionViewFlowLayout, pageView: WJPageView) {
        super.init(frame: .zero)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        self.pageView = pageView
        
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
//    init(dataSource: WJSegmentViewDataSource) {
//        super.init(frame: .zero)
//        self.dataSource = dataSource;
//        self.addSubview(self.collectionView)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        if self.flowLayout.scrollDirection == .horizontal {
            var selfWidth: CGFloat = 0.0
            var selfHeight: CGFloat = 0.0
            var maxHeight: CGFloat = 0.0
            var buttonWidth: CGFloat = 0.0
            for item in self.items {
                let intrinsicSize = item.intrinsicContentSize
                buttonWidth = intrinsicSize.width
                selfWidth += buttonWidth
                maxHeight = maxHeight > intrinsicSize.height ? maxHeight : intrinsicSize.height
            }
            selfHeight = maxHeight
            for item in self.items {
                item.maxHeightOrWidth = maxHeight
            }
            return CGSize(width: selfWidth, height: selfHeight)
        } else {
            var selfWidth: CGFloat = 0.0
            var selfHeight: CGFloat = 0.0
            var maxWidth: CGFloat = 0.0
            for item in self.items {
                let intrinsicSize = item.intrinsicContentSize
                selfHeight += intrinsicSize.height
                maxWidth = maxWidth > intrinsicSize.width ? maxWidth : intrinsicSize.width
            }
            selfWidth = maxWidth
            for item in self.items {
                item.maxHeightOrWidth = maxWidth
            }
            return CGSize(width: selfWidth, height: selfHeight)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
    
    private let WJSegmentItemReUsedID = "WJSegmentItemReUsedID"
    
    private lazy var cloneIndicator: UIImageView = {
        let indicator = UIImageView()
        let defaultIndicator = self.segmentView?.selectedItem.indicatorView
        indicator.image = defaultIndicator?.image
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = defaultIndicator?.layer.cornerRadius ?? 0
        indicator.backgroundColor = defaultIndicator?.backgroundColor
        self.segmentView?.collectionView.addSubview(indicator)
        return indicator
    }()
    
}

extension WJSegmentView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WJSegmentItemReUsedID, for: indexPath)
        let item = self.items[indexPath.row]
        cell.contentView.addSubview(item)
        let size = self.getItemSize(indexPath: indexPath)
        item.frame = CGRect(origin: CGPoint.zero, size: size)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.flowLayout.scrollDirection == .horizontal {
            return self.getItemSize(indexPath: indexPath)
        } else {
            let height = self.getItemSize(indexPath: indexPath).height
            let width = self.items[indexPath.row].maxHeightOrWidth
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setSelctedState(indexPath: indexPath)
        if self.didSelectItem != nil {
            self.didSelectItem!(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if self.didDeselectedItem != nil {
            self.didDeselectedItem!(indexPath.row)
        }
    }
    
    func setSelctedState(indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
    
    private func getItemSize(indexPath: IndexPath) -> CGSize {
        let item = self.items[indexPath.row]
        let itemSize: CGSize
        if self.flowLayout.scrollDirection == .horizontal {
            itemSize = CGSize(width:item.intrinsicContentSize.width, height:item.maxHeightOrWidth)
        } else {
            itemSize = CGSize(width:item.maxHeightOrWidth, height:item.intrinsicContentSize.height)
        }
        return itemSize
    }
    
    func startIndicatorAnimation(offset: CGFloat, index: Int, isIndexIncreaze: Bool, pageWidth: CGFloat) {
        print("\(index)")
    }

}
