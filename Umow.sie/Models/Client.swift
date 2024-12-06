//
//  Client.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 20/10/2024.
//

import Foundation

struct Client: Codable, Equatable {
    let id: Int
    var name: String
    var surname: String
    var phoneNumber: String
    var email: String
    var password: String
    var preferredService: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.surname = ""
        self.phoneNumber = ""
        self.email = ""
        self.password = ""
        self.preferredService = 0
    }
    
    init(id: Int, name: String, surname: String, phoneNumber: String, email: String, password: String, preferredService: Int) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.preferredService = preferredService
    }
    
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
