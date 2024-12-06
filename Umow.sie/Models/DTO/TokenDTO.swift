//
//  TokenDTO.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import Foundation

struct TokenDTO: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "tokenValue"
    }
}
