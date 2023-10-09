//
//  ViewController.swift
//  WJButtonDemo
//
//  Created by zhouweijie on 2019/1/14.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //标题在上
        let titleInTop = WJButton()
        titleInTop.titlePosition = .top
        titleInTop.setImage(UIImage(named: "video_icon"), for: .normal)
        titleInTop.setTitle("titleInTop", for: .normal)
        titleInTop.contentSpacing = 30
        titleInTop.frame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 200, height: 50))
        titleInTop.backgroundColor = UIColor.gray
        titleInTop.ajustTitleAndImage()
        self.view.addSubview(titleInTop)
        //标题在下
        let titleInBottom = WJButton(frame: CGRect(origin: CGPoint(x: 50, y: 120), size: CGSize(width: 200, height: 50)))
        titleInBottom.titlePosition = .bottom
        titleInBottom.setImage(UIImage(named: "video_icon"), for: .normal)
        titleInBottom.setTitle("titleInBottom", for: .normal)
        titleInBottom.backgroundColor = UIColor.gray
        titleInBottom.contentSpacing = 30
        titleInBottom.ajustTitleAndImage()
        self.view.addSubview(titleInBottom)
        //标题在左
        let titleInLeft = WJButton()
        titleInLeft.titlePosition = .left
        titleInLeft.frame = CGRect(origin: CGPoint(x: 50, y: 190), size: CGSize(width: 200, height: 50))
        titleInLeft.setImage(UIImage(named: "video_icon"), for: .normal)
        titleInLeft.setTitle("titleInLeft", for: .normal)
        titleInLeft.backgroundColor = UIColor.gray
        titleInLeft.contentSpacing = 30
        titleInLeft.ajustTitleAndImage()
        self.view.addSubview(titleInLeft)
        //标题在右
        let titleInRight = WJButton(frame: CGRect(origin: CGPoint(x: 50, y: 260), size: CGSize(width: 200, height: 50)))
        titleInRight.titlePosition = .right
        titleInRight.setImage(UIImage(named: "video_icon"), for: .normal)
        titleInRight.setTitle("titleInRight", for: .normal)
        titleInRight.backgroundColor = UIColor.gray
        titleInRight.contentSpacing = 30
        titleInRight.ajustTitleAndImage()
        self.view.addSubview(titleInRight)
        //使用固有内容大小
        let useIntrinsicSize = WJButton()
        useIntrinsicSize.titlePosition = .bottom
        useIntrinsicSize.setImage(UIImage(named: "video_icon"), for: .normal)
        useIntrinsicSize.setTitle("useIntrinsicSize", for: .normal)
        useIntrinsicSize.backgroundColor = UIColor.gray
//        useIntrinsicSize.contentSpacing = 30
        useIntrinsicSize.frame = CGRect(origin: CGPoint(x: 50, y: 330), size: useIntrinsicSize.intrinsicContentSize)
        useIntrinsicSize.ajustTitleAndImage()
        self.view.addSubview(useIntrinsicSize)
        //增加上下左右边距
        let insets = WJButton()
        insets.titlePosition = .bottom
        insets.insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        insets.setImage(UIImage(named: "video_icon"), for: .normal)
        insets.setTitle("insets", for: .normal)
        insets.frame = CGRect(origin: CGPoint(x: 50, y: 380), size: insets.intrinsicContentSize)
        insets.backgroundColor = UIColor.gray
        insets.ajustTitleAndImage()
        self.view.addSubview(insets)
        //增加文字和图片间距
        let contentSpacing = WJButton()
        contentSpacing.titlePosition = .bottom
        contentSpacing.contentSpacing = 20
        contentSpacing.setImage(UIImage(named: "video_icon"), for: .normal)
        contentSpacing.setTitle("contentSpacing", for: .normal)
        contentSpacing.backgroundColor = UIColor.gray
        contentSpacing.frame = CGRect(origin: CGPoint(x: 50, y: 450), size: contentSpacing.intrinsicContentSize)
        contentSpacing.ajustTitleAndImage()
        self.view.addSubview(contentSpacing)
        //图片偏移
        let imageOffset = WJButton()
        imageOffset.titlePosition = .bottom
        imageOffset.setImage(UIImage(named: "video_icon"), for: .normal)
        imageOffset.setTitle("imageOffset", for: .normal)
        imageOffset.frame = CGRect(origin: CGPoint(x: 50, y: 520), size: CGSize(width: 200, height: 50))
        imageOffset.imageOffset = 80.0
        imageOffset.backgroundColor = UIColor.gray
        contentSpacing.ajustTitleAndImage()
        self.view.addSubview(imageOffset)
        //标题偏移
        let titleOffset = WJButton()
        titleOffset.titlePosition = .bottom
        titleOffset.setImage(UIImage(named: "video_icon"), for: .normal)
        titleOffset.setTitle("titleOffset", for: .normal)
        titleOffset.frame = CGRect(origin: CGPoint(x: 50, y: 590), size: CGSize(width: 200, height: 50))
        titleOffset.titleOffset = 30.0
        titleOffset.backgroundColor = UIColor.gray
        contentSpacing.ajustTitleAndImage()
        self.view.addSubview(titleOffset)

        //测试修改内容后大小改变
        testButton = insets
    }
    
    var testButton: WJButton?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testButton?.setTitle("testtesttesttesttesttesttest", for: .normal)
        if testButton != nil {
            testButton!.frame = CGRect(origin: testButton!.frame.origin, size: testButton!.intrinsicContentSize)
            testButton?.ajustTitleAndImage()
        }
    }

}

