//
//  YYSegmentButtonItem.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/30.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYSegmentButtonCell: UICollectionViewCell {
    //MARK: - lazy properties
    private(set) lazy var titleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont(pingFangSemiboldSize: 20)
        return button
    }()
    private(set) lazy var indicator: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor(hex: "333333")
        imageV.layer.masksToBounds = true
        imageV.isHidden = true
        return imageV
    }()
    private(set) lazy var indicatorWidthConstraint: NSLayoutConstraint = {
        let constraint = self.indicator.widthAnchor.constraint(equalToConstant: 6)
        return constraint
    }()
    private(set) lazy var indicatorHeightConstraint: NSLayoutConstraint = {
        let constraint = self.indicator.heightAnchor.constraint(equalToConstant: 3)
        return constraint
    }()
    private(set) lazy var indicatorTopConstraint: NSLayoutConstraint = {
        let constraint = self.indicator.topAnchor.constraint(equalTo: self.titleButton.bottomAnchor, constant: 4)
        return constraint
    }()
    private(set) lazy var indicatorBottomConstraint: NSLayoutConstraint = {
        let constraint = self.indicator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        return constraint
    }()
    
    //MARK: - life functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(titleButton)
        self.contentView.addSubview(indicator)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            titleButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 0),
//            titleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            titleButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 0),
            ])
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorTopConstraint,
            indicatorHeightConstraint,
            indicatorWidthConstraint,
            indicator.centerXAnchor.constraint(equalTo: titleButton.centerXAnchor, constant: 0),
            indicatorBottomConstraint,
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.layer.cornerRadius = indicatorHeightConstraint.constant/2.0
    }
    
    //MARK: - public functions
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.indicator.isHidden = false
            } else {
                self.indicator.isHidden = true
            }
        }
    }
    
    //MARK: - other properties
    
}

//MARK: -private functions
extension YYSegmentButtonCell {
    
}

