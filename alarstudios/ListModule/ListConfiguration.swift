//
//  ListConfiguration.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

final class ListConfigurator {
    
    func configureView(router: Router) -> UIViewController {
        let container = TempDependencies.self
        let networkManager = ListNetworkManagerImpl(networkManager: container.baseNeworkManager,
                                                    requestFabric: container.requestFabric)
        let imageDowloader = container.imageDownloader
        let viewModel = ListViewModelImpl(networkManager: networkManager, router: router, imageDownloader: imageDowloader)
        let listViewController = ListViewController(viewModel: viewModel)
        viewModel.view = listViewController
        
        return listViewController
    }
}
