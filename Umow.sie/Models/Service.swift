//
//  Service.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

struct Service: Identifiable {
    let id: Int
    var name: String
    var duration: Int
    var price: Double
    var description: String
    
    init(id: Int, name: String, duration: Int, price: Double, description: String) {
        self.id = id
        self.name = name
        self.duration = duration
        self.price = price
        self.description = description
    }
}

extension Service: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "serviceID"
        case name = "serviceName"
        case duration = "serviceSpan"
        case price = "servicePrice"
        case description = "serviceDescription"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
