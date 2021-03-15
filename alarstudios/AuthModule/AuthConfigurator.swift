//
//  AuthConfigurator.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

final class AuthConfigurator {
    
    func configureView(router: Router) -> UIViewController {
        let container = TempDependencies.self
        let networkManager = AuthNetworkManagerImpl(networkManager: container.baseNeworkManager,
                                                    requestFabric: container.requestFabric)
        let viewModel = AuthViewModelImpl(networkManager: networkManager, router: router)
        let authViewController = AuthViewController(viewModel: viewModel)
        viewModel.view = authViewController
        
        return authViewController
    }
}
