//
//  UIStackViewExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     spacing: CGFloat = 5.0,
                     distribution: UIStackView.Distribution = .fillEqually) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
}
