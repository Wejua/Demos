//
//  TableViewBatchDeleteBottomBar.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/27.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class TableViewBatchDeleteBottomBar: UIView {

    private(set) lazy var batchSelectB: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#999999"), for: .normal)
        button.setTitle("全选", for: .normal)
        button.setImage(UIImage(named: "collection_normal"), for: .normal)
        button.setImage(UIImage(named: "collection_selected"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.titleLabel?.font = UIFont(name: "PingFangHK-Regular", size: 16)
        button.addTarget(self, action: #selector(didClickBatchSelectButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var deleteB: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#FF502E"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangHK-Medium", size: 16)
        button.layer.borderColor = UIColor(hex: "#F8674B").cgColor
        button.setTitle("删除", for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 15, bottom: 4, right: 15)
        button.layer.cornerRadius = button.intrinsicContentSize.height/2.0
        button.addTarget(self, action: #selector(didClickDeleteButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "E7E7E7")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(separatorLine)
        self.addSubview(batchSelectB)
        self.addSubview(deleteB)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: self.topAnchor),
            separatorLine.leftAnchor.constraint(equalTo: self.leftAnchor),
            separatorLine.rightAnchor.constraint(equalTo: self.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
            ])
        batchSelectB.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            batchSelectB.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            batchSelectB.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            ])
        deleteB.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteB.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            deleteB.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var enable: Bool = true {
        didSet {
            self.batchSelectB.isEnabled = enable
            self.deleteB.isEnabled = enable
        }
    }
    
    weak var delegate: TableViewBatchDeleteBottomBarDelegate?
    
    
    var heightConstraint: NSLayoutConstraint?
    
}
///private functions
extension TableViewBatchDeleteBottomBar {
    @objc private func didClickDeleteButton(button: UIButton) {
        delegate?.TableViewBatchDeleteBottomBarDidClickDeleteButton(button: button)
    }
    
    @objc private func didClickBatchSelectButton(button: UIButton) {
        delegate?.TableViewBatchDeleteBottomBarDidClickBatchSelectButton(button: button)
    }
}

protocol TableViewBatchDeleteBottomBarDelegate: NSObjectProtocol {
    func TableViewBatchDeleteBottomBarDidClickDeleteButton(button: UIButton)
    func TableViewBatchDeleteBottomBarDidClickBatchSelectButton(button: UIButton)
}

