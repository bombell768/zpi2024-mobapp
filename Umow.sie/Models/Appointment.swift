//
//  Appointment.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 21/11/2024.
//

import Foundation

struct Appointment: Codable {
    let id: Int
    var employeeId: Int
    var customerId: Int
    var servicesIds: [Int]
    var date: Date
    var time: Time
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "salonID"
        case employeeId = "employeeID"
        case customerId = "customerID"
        case servicesIds = "serviceIDList"
        case date = "visitDate"
        case time = "visitStartTime"
        case status = "visitStatus"
    }
}
