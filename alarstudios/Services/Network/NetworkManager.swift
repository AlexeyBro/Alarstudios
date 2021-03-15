//
//  NetworkManager.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import UIKit

protocol NetworkManager {
    var session: URLSession { get }
    func makeRequest<T: Decodable>(with request: URLRequest?,
                                   decode: @escaping (Decodable) -> T?,
                                   completion: @escaping (Result<T, APIError>) -> Void)
    
}

final class BaseNetworkManager: NetworkManager {
    
    var session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
}

extension NetworkManager {
    
    typealias JSONCompletionHandler = (Decodable?, APIError?) -> Void
    
    func makeRequest<T: Decodable>(with request: URLRequest?,
                                   decode: @escaping (Decodable) -> T?,
                                   completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodeType: T.self) { (json , error) in
            
            guard let jsonResponse = json else {
                if let errorResponse = error {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(.invalidData))
                }
                return
            }
            if let value = decode(jsonResponse) {
                completion(.success(value))
            } else {
                completion(.failure(.jsonParsingFailure))
            }
        }
        task?.resume()
    }
    
    private func decodingTask<T: Decodable>(with request: URLRequest?,
                                            decodeType: T.Type,
                                            completion: @escaping JSONCompletionHandler) -> URLSessionDataTask? {
        
        guard let request = request else { return nil }
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error as? URLError {
                if error.code.rawValue == -1009 { completion(nil, .networkFail) }
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .requestFail)
                return
            }
            
            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodeType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonParsingFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .requestFail)
            }
        }
        return task
    }
}
