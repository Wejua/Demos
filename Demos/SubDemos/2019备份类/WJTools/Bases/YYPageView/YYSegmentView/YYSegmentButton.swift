//
//  YYButton.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/10/8.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYSegmentButton: UIButton {
    //MARK: - lazy properties
    
    //MARK: - life functions
    convenience init(fixedSize: CGSize) {
        self.init(frame: .zero)
        self.fixedSize = fixedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public functions
    override var intrinsicContentSize: CGSize {
        if (fixedSize != nil) {
            return fixedSize!
        } else {
            return super.intrinsicContentSize
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.titleLabel?.font = selectedFont ?? self.titleLabel?.font
                self.layer.borderColor = selectedBorderColor?.cgColor ?? self.layer.borderColor
            } else {
                self.titleLabel?.font = normalFont
                self.layer.borderColor = normalBorderColor?.cgColor ?? self.layer.borderColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.titleLabel?.font = normalFont ?? self.titleLabel?.font
                self.layer.borderColor = normalBorderColor?.cgColor ?? self.layer.borderColor
            } else {
                self.titleLabel?.font = disableFont ?? self.titleLabel?.font
                self.layer.borderColor = disableBorderColor?.cgColor ?? self.layer.borderColor
            }
        }
    }
    
    func setTitleFont(_ font: UIFont, for state: UIControl.State) {
        if state == .normal {
            normalFont = font
        } else if state == .selected {
            selectedFont = font
        } else if state == .disabled {
            disableFont = font
        }
    }
    
    func setBorderColor(_ color: UIColor, for state: UIControl.State) {
        if state == .normal {
            normalBorderColor = color
        } else if state == .selected {
            selectedBorderColor = color
        } else if state == .disabled {
            disableBorderColor = color
        }
    }
    
    //MARK: - other properties
    private(set) var fixedSize: CGSize?
    
    private(set) var normalFont: UIFont?
       
    private(set) var selectedFont: UIFont?
    
    private(set) var disableFont: UIFont?
    
    private(set) var normalBorderColor: UIColor?
    
    private(set) var selectedBorderColor: UIColor?
    
    private(set) var disableBorderColor: UIColor?
    
}
