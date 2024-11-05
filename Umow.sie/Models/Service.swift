//
//  Service.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/11/2024.
//

import Foundation

struct Service {
    var ID: Int
    var name: String
    var description: String
    var duration: Int
    var price: Double
    var category: Int
    
    enum CodingKeys: String, CodingKey {
        case ID = "serviceID"
        case name = "serviceName"
        case description = "serviceDescription"
        case duration = "serviceDuration"
    }
}
