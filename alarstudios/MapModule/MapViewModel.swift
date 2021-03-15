//
//  MapViewModel.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import Foundation

protocol MapViewModel {
    func setData()
}

class MapViewModelImpl: MapViewModel {
    
    weak var view: MapViewProtocol?
    private let listModel: List
    
    init(listModel: List) {
        self.listModel = listModel
    }
    
    func setData() {
        let latitude = listModel.lat
        let longitude = listModel.lon
        let descriptionMapViewModel = DescriptionMapViewModel(id: listModel.id,
                                                              name: listModel.name,
                                                              country: listModel.country)
        view?.setCoordinate(with: latitude, longitude: longitude)
        view?.setDescription(with: descriptionMapViewModel)
    }
}
