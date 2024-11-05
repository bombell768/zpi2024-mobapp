//
//  Salon.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

struct Salon: Codable {
    var ID: Int
    var name: String
    var phoneNumber: String
    var city: String
    var street: String
    var buildingNumber: String
    var postalCode: String
    
    func getAddress() -> String {
        return self.street + self.buildingNumber + ", " + self.postalCode +
        self.city
    }
    
    enum CodingKeys: String, CodingKey {
        case ID = "salonID"
        case name = "salonName"
        case phoneNumber = "salonDialNumber"
        case city = "salonCity"
        case street = "salonStreet"
        case buildingNumber = "salonBuildingNumber"
        case postalCode =  "salonPostalCode"
    }
}
