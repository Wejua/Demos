//
//  EditingViewController.swift
//  AppStatePreservationAndRestorationDemo
//
//  Created by zhouweijie on 2019/4/19.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: (UIScreen.main.bounds.width-200)/2.0, y: 200, width: 200, height: 30))
        textField.backgroundColor = UIColor.lightGray
        return textField
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.restorationClass = EditingViewController.self
        self.restorationIdentifier = "EditingViewController"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.view.addSubview(textField)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedView))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tappedView() {
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
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

extension EditingViewController: UIViewControllerRestoration {
    static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        let vc = ViewController(nibName: nil, bundle: nil)
        return vc
    }
}
