//
//  Salon.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

@Observable class Salon: Identifiable, Equatable {
    static func == (lhs: Salon, rhs: Salon) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.phoneNumber == rhs.phoneNumber &&
               lhs.city == rhs.city &&
               lhs.street == rhs.street &&
               lhs.buildingNumber == rhs.buildingNumber &&
               lhs.postalCode == rhs.postalCode &&
               lhs.averageRating == rhs.averageRating
    }
    
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
        return self.street + " " + self.buildingNumber + ", " + self.postalCode + " " +  self.city
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.city = try container.decode(String.self, forKey: .city)
        self.street = try container.decode(String.self, forKey: .street)
        self.buildingNumber = try container.decode(String.self, forKey: .buildingNumber)
        self.postalCode = try container.decode(String.self, forKey: .postalCode)
        self.averageRating = 0.0
    }


   func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(id, forKey: .id)
       try container.encode(name, forKey: .name)
       try container.encode(phoneNumber, forKey: .phoneNumber)
       try container.encode(city, forKey: .city)
       try container.encode(street, forKey: .street)
       try container.encode(buildingNumber, forKey: .buildingNumber)
       try container.encode(postalCode, forKey: .postalCode)
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
