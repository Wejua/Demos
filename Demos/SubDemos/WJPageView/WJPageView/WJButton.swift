//
//  WJButton.swift
//  customButton
//
//  Created by zhouweijie on 2019/1/14.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

/// title可以相对于image上下左右四个方向排列，有实际内容大小和不固定大小两种显示方式，contentEdgeInsets增加上下左右边距
@objcMembers class WJButton: UIButton {
    
    enum titlePosition: Int {
        case top, bottom, left, right
    }
    
    var titlePosition: titlePosition = .right {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// 文字和图片间距
    var contentSpacing: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    ///与image对齐时的偏移量
    var titleOffset: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    ///与title对齐时的偏移量
    var imageOffset: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    /// 忽略frame中的size，使用固有内容大小，默认false
    var useIntrinsicSize: Bool = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///返回不使用实际内容大小的button
    class func fixedSizeButton(frame: CGRect, titlePosition: titlePosition, contentSpacing: CGFloat) -> WJButton {
        let button = WJButton.init(frame: frame)
        button.useIntrinsicSize = false
        button.contentEdgeInsets = .zero
        button.titlePosition = titlePosition
        button.contentSpacing = contentSpacing
        return button
    }
    ///返回根据实际内容大小加上contentEdgeInsets大小的button，titleLabel的大小是一行的大小，不带换行的哦
    class func intrinsicSizeButton(titlePosition: titlePosition, padding: UIEdgeInsets, contentSpacing: CGFloat) -> WJButton {
        let button = WJButton.init(frame: .zero)
        button.useIntrinsicSize = true
        button.titlePosition = titlePosition
        button.contentEdgeInsets = padding
        button.contentSpacing = contentSpacing
        return button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let intrinsicSize = self.intrinsicContentSize
        if self.useIntrinsicSize {
            var frame = self.frame
            frame.size = intrinsicSize
            self.frame = frame
        }
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        imageView?.contentMode = .center
        titleLabel?.contentMode = .center
        let titleSize = titleLabel?.attributedText?.size() ?? .zero
        let imageSize = imageView?.image?.size ?? .zero
        //调整子视图位置（修改内容后自动适应）
        var titleFrame = self.titleLabel?.frame ?? .zero
        titleFrame = CGRect(x: titleFrame.minX + (titleFrame.size.width - titleSize.width)/2, y: titleFrame.minY + (titleFrame.size.height - titleSize.height)/2, width: titleSize.width, height: titleSize.height)
        self.titleLabel?.frame = titleFrame
        var imageFrame = self.imageView?.frame ?? .zero
        imageFrame = CGRect(x: imageFrame.minX + (imageFrame.size.width - imageSize.width)/2, y: imageFrame.minY + (imageFrame.size.height - imageSize.height)/2, width: imageSize.width, height: imageSize.height)
        imageView?.frame = imageFrame
        arrange(titleSize: titleSize, imageSize: imageSize, atPosition: self.titlePosition, withSpacing: self.contentSpacing)
    }
    
    ///使用titleEdgeInsets 和 imageEdgeInsets调整位置
    private func arrange(titleSize: CGSize, imageSize: CGSize, atPosition position: titlePosition, withSpacing spacing: CGFloat) {
        switch (position) {
        case .top:
            titleEdgeInsets = UIEdgeInsets(top: -(imageSize.height + spacing), left: -(imageSize.width)+titleOffset, bottom: 0, right: -titleOffset)
            imageEdgeInsets = UIEdgeInsets(top: titleSize.height+spacing, left: imageOffset, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleEdgeInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width)+titleOffset, bottom: titleSize.height, right: -titleOffset)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height+spacing), left: imageOffset, bottom: 0, right: -titleSize.width)
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: titleOffset, left: -(imageSize.width*2+spacing), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0, bottom: 0, right: -(titleSize.width*2+spacing))
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: titleOffset, left: 0, bottom: 0, right: -spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0, bottom: 0, right: spacing)
        }
    }
    
    /// 返回固有内容大小加上contentEdgInsets的大小
    override var intrinsicContentSize: CGSize {
        let imageSize = self.imageView?.image?.size
        let titleSize = self.titleLabel?.attributedText?.size()
        if self.titlePosition == .left || self.titlePosition == .right {
            let imageWidth = imageSize?.width ?? 0
            let titleWidth = titleSize?.width ?? 0
            let width: CGFloat = self.contentEdgeInsets.left + self.contentEdgeInsets.right + titleWidth + imageWidth + contentSpacing
            let height = (imageSize?.height ?? 0) > (titleSize?.height ?? 0) ? (imageSize?.height ?? 0) : (titleSize?.height ?? 0)
            return CGSize(width: width, height: height+self.contentEdgeInsets.top+self.contentEdgeInsets.bottom)
        } else {
            let width = (imageSize?.width ?? 0) > (titleSize?.width ?? 0) ? (imageSize?.width ?? 0) : (titleSize?.width ?? 0)
            let imageHeight = imageSize?.height ?? 0
            let titleHeight = titleSize?.height ?? 0
            let height = self.contentEdgeInsets.top + self.contentEdgeInsets.bottom + titleHeight + imageHeight + contentSpacing
            return CGSize(width: width+self.contentEdgeInsets.left+self.contentEdgeInsets.right, height: height)
        }
    }
    
    var intrinsicSizeWithoutContentEdgeInsets: CGSize {
        let imageSize = self.imageView?.image?.size
        let titleSize = self.titleLabel?.attributedText?.size()
        if self.titlePosition == .left || self.titlePosition == .right {
            let imageWidth = imageSize?.width ?? 0
            let titleWidth = titleSize?.width ?? 0
            let width: CGFloat = titleWidth + imageWidth + contentSpacing
            let height = (imageSize?.height ?? 0) > (titleSize?.height ?? 0) ? (imageSize?.height ?? 0) : (titleSize?.height ?? 0)
            return CGSize(width: width, height: height)
        } else {
            let width = (imageSize?.width ?? 0) > (titleSize?.width ?? 0) ? (imageSize?.width ?? 0) : (titleSize?.width ?? 0)
            let imageHeight = imageSize?.height ?? 0
            let titleHeight = titleSize?.height ?? 0
            let height = titleHeight + imageHeight + contentSpacing
            return CGSize(width: width, height: height)
        }
    }
    
    
}

