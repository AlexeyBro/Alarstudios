//
//  UIViewControllerExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

extension UIViewController {
    func showBaseInfoAlert(title: String? = nil, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
