//
//  ViewController.swift
//  WJPageView
//
//  Created by zhouweijie on 2019/2/1.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textButton: WJButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.pageView)
        pageView.selectedIndex = 2
    }
    
    let titles = ["首页","我的","房地产","商业","","新闻","美丽中国","科技","工业","数据"]
    
    lazy var buttons: [WJButton] = {
        var items = [WJButton]()
        for title in self.titles {
            let button = WJButton.intrinsicSizeButton(titlePosition: .left, padding: .zero, contentSpacing: 0)
            if title != "" {
                button.setTitle(title, for: .normal)
            }
            if title.count > 2{
                button.setImage(UIImage(named: "sort-up"), for: .normal)
                button.contentSpacing = 3
            } else if title.count == 0 {
                button.setImage(UIImage(named: "sort-up"), for: .normal)
            }
            button.titleLabel?.textAlignment = .right
            button.setTitleColor(UIColor.red, for: .normal)
            button.setTitleColor(UIColor.blue, for: .selected)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            button.isHighlighted = false
            button.isUserInteractionEnabled = false
//            let item = SegmentItem(button: button, indicator: nil)
//            item.indicatorView.backgroundColor = UIColor.blue
//            item.indicatorInset = UIEdgeInsets(top: 2, left: 0, bottom: 1, right: 0)
            items.append(button)
        }
        return items
    }()
    
    lazy var segmentView: WJSegmentView = {
        let segmentView = WJSegmentView(buttons: self.buttons)
        segmentView.backgroundColor = UIColor.lightGray
        return segmentView
    }()
    
    lazy var views: [UIView] = {
        var views = [UIView]()
        for i in 0..<self.titles.count {
            views.append(UIView(frame: .zero))
        }
        return views
    }()
    
    lazy var pageView: WJPageView = {
        let pageView = WJPageView(buttons: self.buttons, views: self.views)
        pageView.detailView.backgroundColor = UIColor.gray
        pageView.flowLayout.scrollDirection = .vertical
        pageView.segmentView?.flowLayout.scrollDirection = .vertical
        return pageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frame = self.view.bounds
        frame.size.height -= 50
        frame.origin.y = 50
        self.pageView.frame = frame
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

