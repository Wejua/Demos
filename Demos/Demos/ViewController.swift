//
//  ViewController.swift
//  Demos
//
//  Created by ByteDance on 2023/10/8.
//

import UIKit

class ViewController: UIViewController {

    lazy private var noticeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.text = "这是空项目，Demo在子项目中"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(noticeLabel)
        noticeLabel.sizeToFit()
        noticeLabel.center = self.view.center
    }

}

