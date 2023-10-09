//
//  YYSelectTitleBar.swift
//  YYVideo
//
//  Created by kk_work on 2019/9/17.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

protocol SelectTitleBarDelegate {
    func didClickButton(button: UIButton);
}

class YYSelectTitleBar: UIView {
    
    var delegate: SelectTitleBarDelegate?
    var titleArray = [String]()
    
    private(set) var currentIndex = 0
    
    var selButton: UIButton = UIButton()
    var selLine: UIView = UIView()
    
    init(titleArray: [String], frame: CGRect) {
        super.init(frame: frame)
        
        self.titleArray = titleArray
        setupViews()
        
        // 默认选中第一个
        doSelectIndex(index: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let buttonW: CGFloat = width / CGFloat(titleArray.count)
        for index in 0..<titleArray.count {
            let x: CGFloat = CGFloat(index) * buttonW
            let button: UIButton = UIButton(frame: CGRect(x: x, y: 0, width: buttonW, height: height))
            button.tag = index
            button.addTarget(self, action: #selector(didClickButton(button:)), for: .touchUpInside)
            let str = titleArray[index]
            button.setTitle(str, for: .normal)
            button.setTitleColor(UIColor.init(hex: "999999"), for: .normal)
            button.setTitleColor(UIColor.init(hex: "333333"), for: .selected)
            button.titleLabel?.font = YYFont.regularFont(15)
            addSubview(button)
        }
        
        selLine = UIView.init(frame: CGRect.init(x: 0, y: height-8, width: 11, height: 3))
        selLine.backgroundColor = UIColor.init(hex: "333333")
        selLine.layer.cornerRadius = 1.5
        addSubview(selLine)
        
        let bottomLine = UIView.init(frame: CGRect.init(x: 0, y: height-0.5, width: width, height: 0.5))
        bottomLine.backgroundColor = UIColor.init(hex: "E7E7E7")
        addSubview(bottomLine)
    }
    
    // 主动选中某button
    func doSelectIndex(index: Int) {
        didClickButton(button: getButton(index: index))
    }
    
    // 更新button 标题
    func updateTitle(index: Int, title: String) {
        let button = getButton(index: index)
        button.setTitle(title, for: .normal)
    }
    
    private func getButton(index: Int) -> UIButton {
        var button = UIButton()
        for sub in self.subviews {
            if sub.tag == index {
                button = self.subviews[index] as! UIButton
                break
            }
        }
        return button
    }
    
    
    // 点击方法
    @objc func didClickButton(button: UIButton) {
        //记录当前index
        currentIndex = button.tag
        
        //更新buttonUI
        selButton.isSelected = false
        selButton.titleLabel?.font = YYFont.regularFont(15)
        selButton = button
        selButton.isSelected = true
        selButton.titleLabel?.font = YYFont.mediumFont(16)
        
        // 标记符动画
        UIView.animate(withDuration: 0.1) {
            self.selLine.centerX = button.centerX
        }
        
        if let delegate = self.delegate {
            delegate.didClickButton(button: button)
        }
        
        print("didClick" + button.tag.description)
    }
    
}
