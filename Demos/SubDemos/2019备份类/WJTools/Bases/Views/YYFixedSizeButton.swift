//
//  YYFixedSizeButton.swift
//  YYVideo
//
//  Created by zhouweijie on 11/21/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYFixedSizeButton: UIButton {
    
    private(set) var fixedSize: CGSize

    init(fixedSize: CGSize) {
        self.fixedSize = fixedSize
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return fixedSize
    }

}
