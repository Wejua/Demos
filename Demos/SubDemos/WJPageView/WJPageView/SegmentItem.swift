//
//  SegmentItem.swift
//  customButton
//
//  Created by zhouweijie on 2019/1/28.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

@objcMembers class SegmentItem: UICollectionViewCell {
    
    private(set) var button: WJButton
    
    var direction: UICollectionView.ScrollDirection = .horizontal
    
    var showDefaultIndicator: Bool = true {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private(set) var indicatorView: UIImageView {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var indicatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var defaultIndicatorSize: CGSize = CGSize(width: 20, height: 2) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    func getIndicatorSize() -> CGSize {
        if self.indicatorView.image != nil {
            return self.indicatorView.image!.size
        } else {
            return self.defaultIndicatorSize
        }
    }
    
    override var isSelected: Bool {
        get {
            return self.button.isSelected
        }
        set {
            self.button.isSelected = newValue
            self.indicatorView.isHidden = !newValue
        }
    }
    
    var maxHeightOrWidth: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    init(button: WJButton, indicator: UIImageView?) {
        self.button = button
        if indicator == nil {
            self.indicatorView = UIImageView.init(frame: .zero)
            self.indicatorView.layer.masksToBounds = true
            self.indicatorView.backgroundColor = UIColor.red
        } else {
            self.indicatorView = indicator!
        }
        super.init(frame: .zero)
        self.indicatorView.isHidden = true
        self.addSubview(button)
        self.addSubview(self.indicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var buttonSize = self.button.intrinsicContentSize
        let maxButtonHeight = self.maxHeightOrWidth-indicatorInset.top-self.indicatorSize().height-indicatorInset.bottom
        if buttonSize.height < maxButtonHeight {
            buttonSize = CGSize(width: buttonSize.width, height: maxButtonHeight)
        }
        let indicatorSize = self.indicatorSize()
        self.button.frame = CGRect(origin: .zero, size: buttonSize)
        self.indicatorView.frame = CGRect(origin: CGPoint(x: (buttonSize.width-indicatorSize.width)/2.0+self.indicatorInset.left-self.indicatorInset.right, y: maxHeightOrWidth-indicatorInset.bottom-indicatorSize.height), size: indicatorSize)
        self.indicatorView.layer.cornerRadius = indicatorSize.height/2.0
    }
    
    override var intrinsicContentSize: CGSize {
        let buttonSize = self.button.intrinsicContentSize
        let indicatorSize = self.indicatorSize()
        let height = buttonSize.height + self.indicatorInset.top + indicatorSize.height + self.indicatorInset.bottom
        return CGSize(width: buttonSize.width, height: height)
    }
    
    private func indicatorSize() -> CGSize {
        let buttonSize = self.button.intrinsicContentSize
        var indicatorSize = self.indicatorView.image == nil ? self.defaultIndicatorSize : self.indicatorView.image!.size
        if indicatorSize.width > buttonSize.width {
            indicatorSize = CGSize(width: buttonSize.width, height: self.defaultIndicatorSize.height)
        }
        return indicatorSize
    }
    
}
