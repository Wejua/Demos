//
//  WJButton.swift
//  customButton
//
//  Created by zhouweijie on 2019/1/14.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

/// title可以相对于image上下左右四个方向排列，有实际内容大小和不固定大小两种显示方式，insets增加上下左右边距
@objcMembers class WJButton: UIButton {

    enum titlePosition: Int {
        case top, bottom, left, right
    }
    
    var titlePosition: titlePosition = .right
    
    /// 上下左右边距，调用intrinsicContentSize会加上
    var insets: UIEdgeInsets = .zero

    /// 文字和图片间距
    var contentSpacing: CGFloat = 0.0

    ///与image对齐时的偏移量
    var titleOffset: CGFloat = 0.0//待实现

    ///与title对齐时的偏移量
    var imageOffset: CGFloat = 0.0//title, image 上下左右偏移都要，待实现, 各种情况下调节inset还有待优化
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        if let newTitle = title {
            self.tempTitle = NSMutableAttributedString(string: newTitle)
        }
    }

    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.tempImage = image
    }

    override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        if title != nil {
            self.tempTitle = NSMutableAttributedString(attributedString: title!)
        }
    }

    /// 设置完所有属性之后记得调用这个方法调整位置
    func ajustTitleAndImage() {
        titleLabel?.contentMode = .center
        imageView?.contentMode = .center
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        
        if tempTitle != nil {
            let font = titleLabel?.font ?? UIFont.systemFont(ofSize: 12)
            tempTitle?.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: tempTitle!.length))
        }
        
        let titleSize = titleLabel?.intrinsicContentSize ?? .zero
        let imageSize = imageView?.intrinsicContentSize ?? .zero
        arrange(titleSize: titleSize, imageSize: imageSize, atPosition: self.titlePosition, withSpacing: self.contentSpacing)
    }

    private var tempTitle: NSMutableAttributedString?

    private var tempImage: UIImage?
    
    ///使用titleEdgeInsets 和 imageEdgeInsets调整位置
    private func arrange(titleSize: CGSize, imageSize: CGSize, atPosition position: titlePosition, withSpacing spacing: CGFloat) {
        switch (position) {
        case .top:
            titleEdgeInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: spacing / 2 + titleSize.height, left: -imageSize.width/2, bottom: 0, right: -imageSize.width/2)
        case .bottom:
            titleEdgeInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width/2, bottom: spacing / 2 + titleSize.height, right: -imageSize.width/2)
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        }
    }
    
    /// 返回固有内容大小加上insets的大小
    override var intrinsicContentSize: CGSize {
        let imageSize = tempImage?.size
        let titleSize = tempTitle?.size()
        if self.titlePosition == .left || self.titlePosition == .right {
            let imageWidth = imageSize?.width ?? 0
            let titleWidth = titleSize?.width ?? 0
            let width: CGFloat = insets.left + insets.right + titleWidth + imageWidth + contentSpacing
            let height = (imageSize?.height ?? 0) > (titleSize?.height ?? 0) ? (imageSize?.height ?? 0) : (titleSize?.height ?? 0)
            return CGSize(width: width, height: height+insets.top+insets.bottom)
        } else {
            let width = (imageSize?.width ?? 0) > (titleSize?.width ?? 0) ? (imageSize?.width ?? 0) : (titleSize?.width ?? 0)
            let imageHeight = imageSize?.height ?? 0
            let titleHeight = titleSize?.height ?? 0
            let height = insets.top + insets.bottom + titleHeight + imageHeight + contentSpacing
            return CGSize(width: width+insets.left+insets.right, height: height)
        }
    }
    
    var intrinsicSizeWithoutinsets: CGSize {
        let imageSize = tempImage?.size
        let titleSize = tempTitle?.size()
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
