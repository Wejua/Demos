//
//  TitleBar.swift
//  YPVideo
//
//  Created by zhouweijie on 2019/9/29.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class YYTitleBar: UIView {
    //MARK: - lazy properties
    private(set) lazy var leftStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private(set) lazy var middleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private(set) lazy var rightStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    ///使用setTitle方法后生成的默认button
    private(set) lazy var defaultTitleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(pingFangSCMediumSize: 17)
        button.setTitleColor(UIColor(hex: "333333"), for: .normal)
        return button
    }()
    
    ///底部分割线
    private(set) lazy var bottomLine: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor(hex: "E7E7E7")
        return imageV
    }()
    
    ///默认返回按钮，有可能被移除，所以是可选的
    private(set) lazy var defaultBackButton: YYTitleBarButton = {
        let button = YYTitleBarButton()
        button.setImage(UIImage(named: "返回"), for: .normal)
        button.addTarget(self, action: #selector(didClickBackButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var defaultRightButton: YYTitleBarButton = {
        let button = YYTitleBarButton()
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private lazy var leftEdgeContraint: NSLayoutConstraint = {
        let leftEdgeContraint = leftStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftEdge)
        return leftEdgeContraint
    }()
    
    private lazy var rightEdgeContraint: NSLayoutConstraint = {
        let rightEdgeContraint = rightStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -rightEdge)
        return rightEdgeContraint
    }()
    
    lazy var titleBarHeightConstraint: NSLayoutConstraint = {
        return self.heightAnchor.constraint(equalToConstant: heightWithStatusBar)
    }()
    
    //MARK: - life functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        //添加默认的返回按钮,isHidden改成true时就会隐藏了
        leftStack.addArrangedSubview(defaultBackButton)
        
        self.addSubview(leftStack)
        self.addSubview(middleStack)
        self.addSubview(rightStack)
        self.addSubview(bottomLine)
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftEdgeContraint,
            leftStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            leftStack.heightAnchor.constraint(equalToConstant: heightWithStatusBar - UIApplication.shared.statusBarFrame.height),
            ])
        middleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            middleStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            middleStack.heightAnchor.constraint(equalToConstant: heightWithStatusBar - UIApplication.shared.statusBarFrame.height),
            ])
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightEdgeContraint,
            rightStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            rightStack.heightAnchor.constraint(equalToConstant: heightWithStatusBar - UIApplication.shared.statusBarFrame.height),
            ])
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public functions
    ///设置titleBar左边UIStackView的子视图
    func setLeftButtons(buttons: [UIButton]) {
        leftStack.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
        }
        buttons.forEach { (button) in
            leftStack.addArrangedSubview(button)
        }
    }
    ///设置titleBar中间UIStackView的子视图
    func setMiddleButtons(buttons: [UIButton]) {
        middleStack.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
        }
        buttons.forEach { (button) in
            middleStack.addArrangedSubview(button)
        }
    }
    ///设置titleBar右边UIStackView的子视图
    func setRightButtons(buttons: [UIButton]) {
        rightStack.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
        }
        buttons.forEach { (button) in
            rightStack.addArrangedSubview(button)
        }
    }
    //调用setRightButtons，给定一个默认的YYTitleBarButton
    func setRightImage(imageName: String?, title: String?, target: Any?, action: Selector) {
        defaultRightButton.addTarget(target, action: action, for: .touchUpInside)
        if imageName != nil {
            defaultRightButton.setImage(UIImage(named: imageName!), for: .normal)
        }
        defaultRightButton.setTitle(title, for: .normal)
        setRightButtons(buttons: [defaultRightButton])
    }
    
    ///应该使用这个方法隐藏和显示titleBar，通过修改高度约束为0实现隐藏，这样可以有动画效果
    @objc func setHidden(isHidden: Bool, animate: Bool) {
           if isHidden {
               if animate {
                   UIView.animate(withDuration: titleBarHideAnimationDuration, animations: {
                       self.titleBarHeightConstraint.constant = 0
                       self.viewController_YY?.view.layoutIfNeeded()
                   }) { (complete) in
                       if complete {
                           self.isHidden = true
                       }
                   }
               } else {
                   titleBarHeightConstraint.constant = 0
                   self.isHidden = true
               }
           } else {
               self.isHidden = false
               if animate {
                   UIView.animate(withDuration: titleBarHideAnimationDuration) {
                       self.titleBarHeightConstraint.constant = self.heightWithStatusBar
                       self.viewController_YY?.view.layoutIfNeeded()
                   }
               } else {
                   titleBarHeightConstraint.constant = heightWithStatusBar
               }
           }
       }
    
    /// 类似UIViewController的title
    func setTitle(title: String) {
        setTitle(title: title, titleColor: UIColor(hex: "333333"))
    }
    
    func setTitle(title: String, titleColor: UIColor) {
        defaultTitleButton.titleLabel?.font = UIFont(pingFangSCMediumSize: 17)
        defaultTitleButton.setTitleColor(titleColor, for: .normal)
        defaultTitleButton.setTitle(title, for: .normal)
        setMiddleButtons(buttons: [defaultTitleButton])
    }
    
    ///设置一个居中的视图
    func setTitleView(view: UIView, size: CGSize) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(YYTitleBar.heightWithoutStatusBar - size.height)/2),
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            view.widthAnchor.constraint(equalToConstant: size.width),
            view.heightAnchor.constraint(equalToConstant: size.height),
        ])
    }
    
    //MARK: - other properties
    weak var delegate: TitleBarDelegate?
    
    weak var viewController_YY: UIViewController?
    
    ///titleBar的高度，加上了状态栏高度
    let heightWithStatusBar: CGFloat = UIApplication.shared.statusBarFrame.height + heightWithoutStatusBar
    
    ///titleBar的高度，不包括状态栏高度
    let heightWithoutStatusBar: CGFloat = YYTitleBar.heightWithoutStatusBar
    
    static let heightWithoutStatusBar: CGFloat = 44
    
    ///默认调用setHidden(isHidden: Bool, animate: Bool)方法，使用动画时的时长
    var titleBarHideAnimationDuration: TimeInterval = 0.3
    
    ///离屏幕左边距
    var leftEdge: CGFloat = 0 {
        didSet {
            leftEdgeContraint.constant = leftEdge
        }
    }
    
    ///离屏幕右边距
    var rightEdge: CGFloat = 10 {
        didSet {
            rightEdgeContraint.constant = rightEdge
        }
    }
    
    var shouldPop: Bool = false
    
}

//还未写代理
protocol TitleBarDelegate: NSObjectProtocol {
    
}

//MARK: - private functions
extension YYTitleBar {
    @objc private func didClickBackButton(button: UIButton) {
        if viewController_YY?.presentingViewController != nil && shouldPop == false {
            viewController_YY?.dismiss(animated: true, completion: nil)
        } else {
            viewController_YY?.navigationController?.popViewController(animated: true)
        }
    }
}
