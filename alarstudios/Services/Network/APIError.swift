//
//  APIError.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import Foundation

enum APIError: Error {
    case jsonParsingFailure
    case requestFail
    case invalidData
    case networkFail
    
    var localizedDescription: String {
        switch self {
        case .jsonParsingFailure: return "Ошибка получения данных"
        case .requestFail: return "Ошибка соединения, попробуйте позже"
        case .invalidData: return "Ошибка обработки ответа"
        case .networkFail: return "Ошибка подключения к сети"
        }
    }
}
