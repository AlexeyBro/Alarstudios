//
//  UIButtonExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import UIKit

extension UIButton {
    
    convenience init(title: String?, titleColor: UIColor?) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
}
