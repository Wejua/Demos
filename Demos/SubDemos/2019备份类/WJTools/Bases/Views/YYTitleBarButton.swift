//
//  YYTitleBarButton.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/10/10.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

class YYTitleBarButton: UIButton {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: YYTitleBar.heightWithoutStatusBar, height: YYTitleBar.heightWithoutStatusBar)
    }

}
