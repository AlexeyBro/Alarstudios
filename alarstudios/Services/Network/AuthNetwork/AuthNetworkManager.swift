//
//  AuthNetworkManager.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import Foundation

protocol AuthNetworkManager {
    var networkManager: NetworkManager { get set }
    var requestFabric: RequestFabric { get set }
    func login(with request: LoginRequest, completion: @escaping (Result<LoginResponse, APIError>) -> Void)
}

final class AuthNetworkManagerImpl: AuthNetworkManager {
    
    var networkManager: NetworkManager
    var requestFabric: RequestFabric
    
    init(networkManager: NetworkManager, requestFabric: RequestFabric) {
        self.networkManager = networkManager
        self.requestFabric = requestFabric
    }
    
    func login(with request: LoginRequest, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        let request = requestFabric.makeLoginRequest(loginRequest: request)
        networkManager.makeRequest(with: request, decode: { model in
            return model as? LoginResponse
        }, completion: completion)
    }
}
