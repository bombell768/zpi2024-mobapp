//
//  Client.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation

struct Client: Codable {
    let id: Int
    var name: String
    var surname: String
    var phoneNumber: String
    var email: String
    var password: String
    var preferredService: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "customerID"
        case name = "customerName"
        case surname = "customerSurname"
        case phoneNumber = "customerDialNumber"
        case email = "customerEmail"
        case password = "encryptedCustomerPassword"
        case preferredService =  "serviceCategoryID"
    }
}
