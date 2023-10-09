//
//  ViewController.swift
//  AppStatePreservationAndRestorationDemo
//
//  Created by zhouweijie on 2019/4/16.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: (UIScreen.main.bounds.width-200)/2.0, y: 200, width: 200, height: 30))
        textField.backgroundColor = UIColor.lightGray
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(textField)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.restorationIdentifier = NSStringFromClass(ViewController.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        let text = textField.text
        let isFirst: Bool = textField.isFirstResponder
        coder.encode(text, forKey: "textFieldText")
        coder.encode(isFirst, forKey: "isFirstResponder")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        let text = coder.decodeObject(forKey: "textFieldText") as? String
        let isFirst = coder.decodeBool(forKey: "isFirstResponder")
        textField.text = text
        if isFirst {
            textField.becomeFirstResponder()
        }
    }

}

