//
//  AnimatingCell.swift
//  TableViewCell Height Animation Demo
//
//  Created by zhouweijie on 2019/4/29.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class AnimatingCell: UITableViewCell {

    @IBOutlet weak var success: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var colum: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subscribe: UIImageView!
    @IBOutlet weak var separator: UIImageView!
    
    var shouldNotLayout = false
    
    override func layoutSubviews() {
        if shouldNotLayout {
            return//beginUpdate()+endUpdate()会重新布局，影响动画
        }
        super.layoutSubviews()
    }
    
}
