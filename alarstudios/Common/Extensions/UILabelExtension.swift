//
//  UILabelExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import UIKit

extension UILabel {
    
    convenience init(isWrap: Bool) {
        self.init()
        
        wordWrap(isWrap: isWrap)
    }
    
    func wordWrap(isWrap: Bool) {
        if isWrap {
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        }
    }
}

