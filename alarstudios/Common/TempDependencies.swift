//
//  TempDependencies.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import Foundation

final class TempDependencies {
    
    static let baseNeworkManager = BaseNetworkManager()
    static let requestFabric = RequestFabricImpl()
    static let cacheManager = CacheManagerImpl()
    static let imageDownloader = ImageDownloaderImpl(cache: cacheManager)
}
