//
//  ViewController.swift
//  AppStatePreservationAndRestorationDemo1
//
//  Created by zhouweijie on 2019/4/19.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var hasPresent: Bool = false
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func didTapEditing(_ sender: UIButton) {
        let editingVC = EditingViewController(nibName: nil, bundle: nil)
        self.present(editingVC, animated: true) {
            self.hasPresent = true
        }
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

