//
//  UITablViewCell+Extension.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/7/19.
//  Copyright © 2018 杨凯. All rights reserved.
//

import Foundation


extension UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    static func nib(_ nibNmae :String? = nil) -> UINib{
        return UINib(nibName: nibNmae ?? "\(self)", bundle: nil)
    }
}

extension UITableViewHeaderFooterView {
    
    static var identifier: String {
        return "\(self)"
    }
}

extension UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    static func nib(_ nibNmae :String? = nil) -> UINib{
        return UINib(nibName: nibNmae ?? "\(self)", bundle: nil)
    }
}

extension UICollectionReusableView {
    static var reusableIdentifier: String {
        return "\(self)"
    }
}


