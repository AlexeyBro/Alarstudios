//
//  ListModels.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import Foundation

struct ListResponse: Decodable {
    let status: String
    let page: Int
    let data: [List]
}

struct List: Decodable {
    let id, name, country: String
    let lat, lon: Double
}

struct ImageResponse: Decodable {
    let total: Int
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case total
        case results
    }
}

struct Results: Decodable {
    let id: String
    let resultDescription: String?
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case resultDescription
        case urls
    }
}

struct Urls: Decodable {
    let raw, full, regular, small: String
    let thumb: String
}
