//
//  Router.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

protocol Router {
    func initialViewController()
    func toListViewController()
    func toMapViewController(with listModel: List)
}

final class RouterManager: Router {
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        guard let navigationController = navigationController else { return }
        let authConfigurator = AuthConfigurator()
        let authViewController = authConfigurator.configureView(router: self)
        navigationController.viewControllers = [authViewController]
    }
    
    func toListViewController() {
        guard let navigationController = navigationController else { return }
        let listConfigurator = ListConfigurator()
        let listViewController = listConfigurator.configureView(router: self)
        navigationController.pushViewController(listViewController, animated: true)
    }
    
    func toMapViewController(with listModel: List) {
        guard let navigationController = navigationController else { return }
        let mapConfigurator = MapConfigurator()
        let mapViewController = mapConfigurator.configureView(with: listModel)
        navigationController.pushViewController(mapViewController, animated: true)
    }
}
