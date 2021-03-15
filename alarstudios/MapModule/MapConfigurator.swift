//
//  MapConfigurator.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import UIKit

class MapConfigurator {
    
    func configureView(with listModel: List) -> UIViewController {
        let viewModel = MapViewModelImpl(listModel: listModel)
        let mapViewController = MapViewController(viewModel: viewModel)
        viewModel.view = mapViewController
        
        return mapViewController
    }
}
