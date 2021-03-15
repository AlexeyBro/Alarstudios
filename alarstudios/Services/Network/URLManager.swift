//
//  URLManager.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import Foundation

final class URLManager {
    
    private var baseUrl = "http://www.alarstudios.com/test"
    private var imageUrl = "https://api.unsplash.com/search/photos"

    func getBaseUrl() -> String {
        baseUrl
    }
    
    func getLoginURL() -> String {
        getBaseUrl() + "/auth.cgi"
    }
    
    func getDataURL() -> String {
        getBaseUrl() + "/data.cgi"
    }
    
    func getImageURL() -> String {
        imageUrl
    }
}
