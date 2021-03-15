//
//  UITableViewExtension.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import UIKit

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.description())
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, at indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellType.description(), for: indexPath) as? T
    }
}
