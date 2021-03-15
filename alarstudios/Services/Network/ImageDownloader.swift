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
    let cache: CacheManager
    
    init(cache: CacheManager) {
        self.cache = cache
        
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func downloadImage(with URLString: String, completion: @escaping (Result<UIImage?, APIError>) -> Void) {
        
        guard let url = URL(string: URLString) else { return }
        let request = URLRequest(url: url)
        
        if let cacheImage = cache.checkImageCache(forKey: url) {
            DispatchQueue.main.async {
                completion(.success(cacheImage))
            }
        } else {
            let task = session.dataTask(with: request) { data, response, error in
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.requestFail))
                    return
                }
                
                if let error = error as? URLError {
                    if error.code.rawValue == -1009 { completion(.failure(.networkFail)) }
                }
                
                if response.statusCode == 200 {
                    if let data = data {
                        guard let image = UIImage(data: data) else { return }
                        self.cache.putImageCache(withImage: image, forKey: url)
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
}
