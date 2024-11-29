//
//  Salon.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

struct Salon: Identifiable {
    let id: Int
    var name: String
    var phoneNumber: String
    var city: String
    var street: String
    var buildingNumber: String
    var postalCode: String
    var averageRating: Double? 
    
    init(id: Int, name: String, phoneNumber: String, city: String, street: String, buildingNumber: String, postalCode: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.city = city
        self.street = street
        self.buildingNumber = buildingNumber
        self.postalCode = postalCode
        self.averageRating = 0.0
    }
    
    init () {
        self.id = 0
        self.name = ""
        self.phoneNumber = ""
        self.city = ""
        self.street = ""
        self.buildingNumber = ""
        self.postalCode = ""
    }
    
    func getAddress() -> String {
        return self.street + self.buildingNumber + ", " + self.postalCode +
        self.city
    }
}


extension Salon: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "salonID"
        case name = "salonName"
        case phoneNumber = "salonDialNumber"
        case city = "salonCity"
        case street = "salonStreet"
        case buildingNumber = "salonBuildingNumber"
        case postalCode =  "salonPostalCode"
    }
}
