//
//  YYSegmentView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/30.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYSegmentView: UIView {
    //MARK: - lazy properties
    private(set) lazy var collectionV: YYSegmentCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = YYSegmentCollectionView(frame: .zero, collectionViewLayout: layout)
        view.didFinishReloadData = {[weak self] in self?.setupIndicator()}
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        return view
    }()
    
    private(set) lazy var separator: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor(hex: "#E7E7E7")
        imageV.isHidden = true
        return imageV
    }()
    //仅用于实现indicator位移效果
    private lazy var indicatorCurrentFrame: CGRect = {
        return collectionV.indicator.frame
    }()
    
    //MARK: - life functions
    /// 配置好button，然后传入这个方法中，不均分宽度时（左对齐，width传nil），可以使用button的contentEdgeInsets调整左右间距，会根据button的intrinsicContentSize设置item的大小。根据button的isSelected属性定义选中状态
    ///
    /// - Parameters:
    ///   - buttons: 配置好的button，可以是文字，图片，或者两者都有
    ///   - selectedIndex: 初始化时选中的index
    ///   - divideWidth: 左对齐时给nil，均分宽度就给一个宽度值
    init(buttons: [YYSegmentButton], selectedIndex: Int, divideWidth: CGFloat?) {
        self.isDivideEqually = divideWidth != nil
        self.selectedIndex = selectedIndex
        self.buttons = buttons
        //计算segmentView宽度
        if !isDivideEqually {
            var segmentWidth: CGFloat = 0
            buttons.forEach { (button) in
                //设置为选中，使用选中时候的宽度，这样在不均分（isDivideEqually == false)的情况下，选中其它item字体变大时，所有item位移调整问题
                button.isSelected = true
                segmentWidth += button.intrinsicContentSize.width
            }
            widthDefault = segmentWidth
        } else {
            widthDefault = divideWidth!
        }
        super.init(frame: .zero)
        
        self.addSubview(separator)
        self.addSubview(collectionV)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            ])
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            collectionV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            collectionV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            ])
    }
    /// 默认样式segmentView
    convenience init(titles: [String], selectedIndex: Int, divideWidth: CGFloat?) {
        self.init(titles: titles, selectedIndex: selectedIndex, divideWidth: divideWidth, otherSettings: nil)
    }
    ///默认样式segmentView，可以通过otherSettings，配置默认button的样式
    convenience init(titles: [String], selectedIndex: Int, divideWidth: CGFloat?, otherSettings: ((YYSegmentButton) -> Void)?) {
        var buttons = [YYSegmentButton]()
        titles.forEach({ (title) in
            let button = YYSegmentButton()
            button.setTitle(title, for: .normal)
            button.setTitleFont(UIFont(pingFangSCRegularSize: 15), for: .normal)
            button.setTitleFont(UIFont(pingFangSCSemiboldSize: 18), for: .selected)
            button.setTitleColor(UIColor(hex: "999999"), for: .normal)
            button.setTitleColor(UIColor(hex: "000000"), for: .selected)
            if divideWidth == nil {
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            }
            buttons.append(button)
            otherSettings?(button)
        })
        self.init(buttons: buttons, selectedIndex: selectedIndex, divideWidth: divideWidth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public functions
    
    //MARK: - other properties
    weak var delegate: YYSegmentViewDelegate?
    
    var selectedIndex: Int! {
        didSet {
            if selectedIndex == oldValue {return}//这句可以防止循环调用
            self.buttons[oldValue].isSelected = false
            self.buttons[selectedIndex].isSelected = true
            self.collectionV.reloadData()
            pageView?.setCurrentIndex(index: selectedIndex, animated: true)
        }
    }
    
    private(set) var buttons: [YYSegmentButton]!
    ///是否所有item宽度一样，均分segmentView的宽度，否则就是左对齐样式
    private(set) var isDivideEqually: Bool!
    
    private(set) var divideEquallySpacing: CGFloat?
    
    //可以通过这属性获取segmentView的宽，可以在设置约束或者frame值的时候使用。
    private(set) var widthDefault: CGFloat
    
    var alignCenter: Bool = false
    
    weak var pageView: YYPageView?
    
}

//MARK: -private functions
extension YYSegmentView {
    
    private func setupIndicator() {
        if collectionV.indicator.isHidden == true {return}
        if let selectedItemFrame = collectionV.layoutAttributesForItem(at: IndexPath(item: selectedIndex, section: 0))?.frame {
            let intrinsicSize = collectionV.indicator.intrinsicContentSize
            let newFrame = CGRect(x: selectedItemFrame.midX - intrinsicSize.width/2.0, y: self.bounds.height - intrinsicSize.height - collectionV.indicatorBottomInset, width: intrinsicSize.width, height: intrinsicSize.height)
            collectionV.indicator.frame = newFrame
        }
    }
}

//MARK: - UICollectionViewDataSource, delegate
extension YYSegmentView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        //清除复用button
        cell.contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        //加入button
        let button = buttons[indexPath.row]
        cell.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: 0),
            ])
        //重置button的选中状态
        button.isSelected = self.selectedIndex == indexPath.row ? true : false
        //不使用button的点击，使用cell的点击事件
        button.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //默认使用均分宽度
        var size: CGSize
        if isDivideEqually {
            var segmentWidth: CGFloat = 0
            buttons.forEach { (button) in
                button.isSelected = true
                segmentWidth += button.intrinsicContentSize.width
            }
            let spacing = (widthDefault - segmentWidth)/CGFloat(buttons.count + 1)
            divideEquallySpacing = spacing
            let intrinsicSize = buttons[indexPath.row].intrinsicContentSize
            size = CGSize(width:spacing + intrinsicSize.width , height: collectionView.bounds.height)
        } else {
            let button = buttons[indexPath.row]
            //设置为选中，使用选中时候的宽度，这样在不均分（isDivideEqually == false)的情况下，选中其它item字体变大时，所有item位移调整问题
            button.isSelected = true
            size = CGSize(width: button.intrinsicContentSize.width, height: collectionView.bounds.height)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isDivideEqually {
            return UIEdgeInsets(top: 0, left: divideEquallySpacing!/2.0, bottom: 0, right: divideEquallySpacing!/2.0)
        }
//        else if (alignCenter) {
//            let insetL = widthDefault
//            return UIEdgeInsets(top: 0, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
//        }
        else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.yySegmentViewDidSelectItemAt(index: indexPath.row, button: buttons[indexPath.row], segmentView: self)
        self.selectedIndex = indexPath.row
    }
    
}

protocol YYSegmentViewDelegate: NSObjectProtocol {
    ///可以根据选中的button的isSelected属性判断是否点击的是已经选中的item
    func yySegmentViewDidSelectItemAt(index: Int, button: YYSegmentButton, segmentView: YYSegmentView)
}

protocol YYSegmentViewSelect: NSObjectProtocol {
    
}
