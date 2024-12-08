//
//  RescheduleDTO.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 08/12/2024.
//

import Foundation

struct RescheduleDTO: Codable {
    let userId: Int
    let userRole: String
    let newDate: Date
    let newTime: Time
    
    enum CodingKeys: String, CodingKey {
        case userId = "userID"
        case userRole
        case newDate = "rescheduleDate"
        case newTime = "rescheduleTime"
    }
}
