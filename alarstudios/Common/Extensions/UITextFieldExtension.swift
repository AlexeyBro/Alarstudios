//
//  UITextFieldExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String?, borderStyle: UITextField.BorderStyle, isSecure: Bool = false) {
        self.init()
        
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.autocapitalizationType = .none
        self.isSecureTextEntry = isSecure
    }
}
