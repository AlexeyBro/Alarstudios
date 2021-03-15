//
//  AuthModels.swift
//  alarstudios
//
//  Created by Alex Bro on 12.03.2021.
//

import Foundation

struct LoginRequest {
    let username, password: String?
}

struct LoginResponse: Decodable {
    let status, code: String
}
