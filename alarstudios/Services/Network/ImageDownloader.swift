//
//  ImageDownloader.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import UIKit

protocol ImageDownloader: NetworkManager {
    func downloadImage(with URLString: String, completion: @escaping (Result<UIImage?, APIError>) -> Void)
}

final class ImageDownloaderImpl: ImageDownloader {
    
    var session: URLSession
    var cache: URLCache
    
    init() {
        let size = 100 * 1024 * 1024
        cache = URLCache(memoryCapacity: size, diskCapacity: size, diskPath: "images")
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        session = URLSession(configuration: configuration)
    }
    
    func downloadImage(with URLString: String, completion: @escaping (Result<UIImage?, APIError>) -> Void) {
        
        guard let url = URL(string: URLString) else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.requestFail))
                return
            }
            
            if let error = error as? URLError {
                if error.code.rawValue == -1009 { completion(.failure(.networkFail)) }
            }
            ///if data in cache take cache
            if let cacheData = self.cache.cachedResponse(for: request) {
                guard let image = UIImage(data: cacheData.data) else { return }
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else if response.statusCode == 200 {
                if let data = data {
                    ///put data in cache
                    let cacheData = CachedURLResponse(response: response, data: data)
                    self.cache.storeCachedResponse(cacheData, for: request)
                    
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            } else {
                completion(.failure(.requestFail))
            }
        }
        task.resume()
    }
}
