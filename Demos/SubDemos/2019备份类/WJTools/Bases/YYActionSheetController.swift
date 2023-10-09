//
//  YYActionSheetController.swift
//  YYVideo
//
//  Created by zhouweijie on 11/23/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYActionSheetController: UIViewController {
    //MARK: - 懒加载属性
    private(set) lazy var mask: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "000000")
        view.alpha = 0.3
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickMask))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private(set) lazy var leftCacelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor(hex: "666666"), for: .normal)
        button.titleLabel?.font = UIFont(pingFangSCRegularSize: 13)
        return button
    }()
    
    private(set) lazy var rightConfirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor(hex: "666666"), for: .normal)
        button.titleLabel?.font = UIFont(pingFangSCRegularSize: 13)
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "请选择交易时间"
        label.textAlignment = .center
        label.font = UIFont(pingFangSCSemiboldSize: 13)
        label.textColor = UIColor(hex: "#444444")
        return label
    }()
    
    private(set) lazy var bottomCancelButton: YYFixedSizeButton = {
        let button = YYFixedSizeButton(fixedSize: CGSize(width: YYScreenW, height: 50))
        button.setTitleColor(UIColor(hex: "444444"), for: .normal)
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont(pingFangSCMediumSize: 16)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: "F7F7F7")
        return button
    }()
    
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    //MARK: - 私有方法
    @objc private func cancelAction() {
        self.dismiss(animated: true, completion: nil)
        dismissActionBlock?()
    }
    
    @objc private func didClickMask() {
        cancelAction()
    }
    
    //MARK: - 生命周期方法
    init(contentStack: UIStackView) {
        self.contentStack = contentStack
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    convenience init(pickTitles: [String]) {
        
        self.init(contentStack: UIStackView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mask)
        view.addSubview(contentView)
        mask.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mask.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mask.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            mask.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            mask.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentStack)
        contentView.addSubview(bottomCancelButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            contentStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentLeftInset),
            contentStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -contentRightInset),
        ])
        bottomCancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomCancelButton.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 35),
            bottomCancelButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            bottomCancelButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            bottomCancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
    
    //MARK: - 重写方法
    
    //MARK: - 其它属性
    private(set) var contentStack: UIStackView
    
    private var hasPresented: Bool = false
    
    var contentLeftInset: CGFloat = 15
    
    var contentRightInset: CGFloat = 15
    
    var dismissActionBlock: (() -> Void)?
    
    //MARK: - 公有方法
}

extension YYActionSheetController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

extension YYActionSheetController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        hasPresented ? dismissAnimation(context: transitionContext) : presentAnimation(context: transitionContext)
    }
    
    private func presentAnimation(context: UIViewControllerContextTransitioning) {
        guard let toView = context.view(forKey: UITransitionContextViewKey.to) else {return}
        toView.alpha = 0
        context.containerView.addSubview(toView)
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            toView.alpha = 1
        }) { (finished) in
            context.completeTransition(true)
            self.hasPresented = true
        }
    }
    
    private func dismissAnimation(context: UIViewControllerContextTransitioning) {
        guard let fromView = context.view(forKey: UITransitionContextViewKey.from) else {return}
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            fromView.alpha = 0
        }) { (finished) in
            fromView.removeFromSuperview()
            context.completeTransition(true)
            self.hasPresented = false
        }
    }
    
}
