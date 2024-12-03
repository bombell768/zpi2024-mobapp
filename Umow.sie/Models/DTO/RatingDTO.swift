//
//  Rating.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

struct RatingDTO: Codable, Identifiable {
    let id: Int
    var rating: Double
    var description: String
    var employeeId: Int
    var clientId: Int
    var appointmentId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ratingID"
        case rating = "ratingValue"
        case description = "ratingOpinion"
        case employeeId = "employeeID"
        case clientId = "customerID"
        case appointmentId = "visitID"
    }
}


struct RatingBodyDTO: Codable {
    let id: Int
    var rating: Double
    var description: String
    var employeeId: Int
    var appointmentId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ratingID"
        case rating = "ratingValue"
        case description = "ratingOpinion"
        case employeeId = "employeeID"
        case appointmentId = "visitID"
    }
}

