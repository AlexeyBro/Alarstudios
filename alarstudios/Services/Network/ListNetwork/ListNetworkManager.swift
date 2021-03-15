//
//  ListNetworkManager.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import Foundation

protocol ListNetworkManager {
    var networkManager: NetworkManager { get set }
    var requestFabric: RequestFabric { get set }
    func fetchData(with code: String, currentPage: Int, completion: @escaping (Result<ListResponse, APIError>) -> Void)
    func fetchImage(with query: String, completion: @escaping (Result<ImageResponse, APIError>) -> Void)
}

final class ListNetworkManagerImpl: ListNetworkManager {
    
    var networkManager: NetworkManager
    var requestFabric: RequestFabric
    
    init(networkManager: NetworkManager, requestFabric: RequestFabric) {
        self.networkManager = networkManager
        self.requestFabric = requestFabric
    }
    
    func fetchData(with code: String, currentPage: Int, completion: @escaping (Result<ListResponse, APIError>) -> Void) {
        let request = requestFabric.makeDataRequest(code: code, currentPage: currentPage)
        networkManager.makeRequest(with: request, decode: { model in
            return model as? ListResponse
        }, completion: completion)
    }
    
    func fetchImage(with query: String, completion: @escaping (Result<ImageResponse, APIError>) -> Void) {
        let request = requestFabric.makeImageRequest(query: query)
        networkManager.makeRequest(with: request, decode: { model in
            return model as? ImageResponse
        }, completion: completion)
    }
}
