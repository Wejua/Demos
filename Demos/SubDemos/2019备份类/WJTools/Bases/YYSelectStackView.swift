//
//  YYSelectStackView.swift
//  YYVideo
//
//  Created by zhouweijie on 11/25/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYSelectStackView: UIStackView {
    
    var selectedIndex: Int? {
        didSet {
            guard let selectedIndex = selectedIndex else {return}
            guard 0 <= selectedIndex, selectedIndex < self.arrangedSubviews.count else {return}
            guard let buttons = self.arrangedSubviews as? [UIButton] else {return}
            for button in buttons {
                if button.tag == selectedIndex {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
    }
    
    init(frame: CGRect, selectedIndex: Int?, titles: [String]) {
        self.selectedIndex = selectedIndex
        super.init(frame: frame)
        self.alignment = UIStackView.Alignment.center
        self.distribution = UIStackView.Distribution.fillProportionally
        self.axis = NSLayoutConstraint.Axis.horizontal
        let spacing: CGFloat = 15.0
        let height: CGFloat = 30.0
        self.spacing = spacing
        for index in 0..<titles.count {
            let button = YYSegmentButton(fixedSize: CGSize(width: (YYScreenW-spacing*4)/3.0, height: height))
            button.setBorderColor(UIColor(hex: "FF502E"), for: .selected)
            button.setTitleColor(UIColor(hex: "FF502E"), for: .selected)
            button.setBorderColor(UIColor(hex: "999999"), for: .normal)
            button.setTitleColor(UIColor(hex: "999999"), for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.masksToBounds = true
            button.layer.cornerRadius = height/2.0
            button.titleLabel?.font = UIFont(pingFangHKRegularSize: 13)
            button.addTarget(self, action: #selector(timeStackItemAction(button:)), for: .touchUpInside)
            self.addArrangedSubview(button)
            button.setTitle(titles[index], for: .normal)
            button.tag = index
            if selectedIndex == index {
                button.isSelected = true
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func timeStackItemAction(button: UIButton) {
        selectedIndex = button.tag
        self.didSelectIndexBlock?(button.tag, button)
    }
    
    var didSelectIndexBlock: ((_ index: Int, _ button: UIButton) -> Void)?
    
}
