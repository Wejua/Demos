//
//  WJPageViewController.swift
//  customButton
//
//  Created by zhouweijie on 2019/1/15.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

@objc protocol WJPageViewDatasource: NSObjectProtocol {
    func segmentCellForIndex(index: NSInteger, pageViewController: WJPageViewController) -> UICollectionViewCell
    func segmentCellSizeForIndex(index: NSInteger, pageViewController: WJPageViewController) -> CGSize
    func detailCellForIndex(index: NSInteger, pageViewController: WJPageViewController) -> UICollectionViewCell
    func detailCellSizeForIndex(index: NSInteger, pageViewController: WJPageViewController) -> CGSize
    
    func numberOfPages(pageView: WJPageViewController) -> NSInteger
    ///
    func childControllerForPageAtIndex(index: NSInteger, pageViewController: WJPageViewController)
}

@objc protocol WJPageViewDelegate: NSObjectProtocol {
    @objc optional func willDisplayPageForIndex(index: NSInteger)
    @objc optional func didEndDisplayPageForIndex(index: NSInteger)
    @objc optional func willTapkPageAtIndex(index: NSInteger, selectedState: Bool)
    @objc optional func didTapPageAtIndex(index: NSInteger)
    ///
    func segmentCellForIndex(index: NSInteger, pageViewController: WJPageViewController) -> UICollectionViewCell
    func segmentCellSizeForIndex(index: NSInteger, pageViewController: WJPageViewController) -> CGSize
}

class WJPageViewController: UIViewController {
    enum ContentDirection {
        case vertical
        case horizontal
    }
    
    weak var dataSource: WJPageViewDatasource?
    
    weak var delegate: WJPageViewDelegate?
    
    var detailPageView = WJPageView()
    
    var segmentView = WJSegmentView()
    
    var contentDirection: ContentDirection = .vertical
    
    var isSegmentViewDisjoint: Bool = false
    
    var selectedIndex: Int = 0 {
        didSet {
        }
    }
    
    var buttons = [WJButton]()
    
    var detailViews = [UIView]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isSegmentViewDisjoint {
            switch contentDirection {
            case .vertical:
                segmentView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: segmentView.defaultHeight)
                detailPageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - segmentView.defaultHeight)
            case .horizontal:
                segmentView.frame = CGRect(x: 0, y: 0, width: segmentView.defaultHeight, height: self.view.bounds.height)
                detailPageView.frame = CGRect(x: segmentView.defaultHeight, y: 0, width: self.view.bounds.width - segmentView.defaultHeight, height: self.view.bounds.height)
            }
        } else {
            detailPageView.frame = self.view.bounds
        }
    }
    
    convenience init(buttons: [WJButton], detailViews: [UIView]) {
        self.init(nibName: nil, bundle: nil)
        self.buttons = buttons
        self.detailViews = detailViews
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if !isSegmentViewDisjoint {
            self.view.addSubview(segmentView)
        }
        self.view.addSubview(detailPageView)
        segmentView.collectionView.delegate = self
        detailPageView.collectionView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WJPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.buttons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === segmentView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WJSegmentViewCell.reusedID, for: indexPath)
            return cell
        } else if collectionView === detailPageView.collectionView {
            if indexPath.row < self.detailViews.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
                let childView = self.detailViews[indexPath.row]
                cell.contentView.addSubview(childView)
                childView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor)
                childView.topAnchor.constraint(equalTo: cell.contentView.topAnchor)
                childView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
                childView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
                childView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)//test
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === segmentView.collectionView {
            switch segmentView.collectionViewFlowLayout.scrollDirection {
            case .horizontal:
                return CGSize(width: self.buttons[indexPath.row].intrinsicContentSize.width, height: segmentView.frame.height)
            case .vertical:
                return CGSize(width: segmentView.frame.width, height: self.buttons[indexPath.row].intrinsicContentSize.height)
            }
        } else if collectionView === detailPageView.collectionView {
            return self.detailPageView.frame.size
        }
        return .zero
    }
}
