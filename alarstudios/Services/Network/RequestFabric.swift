//
//  RequestFabric.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import Foundation

protocol RequestFabric {
    func makeLoginRequest(loginRequest: LoginRequest) -> URLRequest?
    func makeDataRequest(code: String, currentPage: Int) -> URLRequest?
    func makeImageRequest(query: String) -> URLRequest?
}

final class RequestFabricImpl: RequestFabric {
    
    private let urlManager = URLManager()
    
    func makeLoginRequest(loginRequest: LoginRequest) -> URLRequest? {
        guard var components = URLComponents(string: urlManager.getLoginURL()) else { return nil }
        var allParams: [String: String] = [:]
        allParams["username"] = loginRequest.username
        allParams["password"] = loginRequest.password
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = "GET"
        return request
    }
    
    func makeDataRequest(code: String, currentPage: Int) -> URLRequest? {
        guard var components = URLComponents(string: urlManager.getDataURL()) else { return nil }
        var allParams: [String: String] = [:]
        allParams["code"] = code
        allParams["p"] = String(currentPage)
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = "GET"
        return request
    }
    
    func makeImageRequest(query: String) -> URLRequest? {
        guard var components = URLComponents(string: urlManager.getImageURL()) else { return nil }
        var allParams: [String: String] = [:]
        allParams["client_id"] = "rEBusit7Ws_rx-6p1FIZ91rj60U4A3pOQ6EtdzPul80"
        allParams["query"] = query
        components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = "GET"
        return request
    }
}
