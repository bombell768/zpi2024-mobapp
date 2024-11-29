//
//  Appointment.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

struct Appointment: Identifiable {
    let id: Int
    var date: Date
    var time: Time
    var status: AppointmentStatus
    var salon: Salon
    var employee: Employee
    var services: [Service]
}


enum AppointmentStatus: String, Codable {
    case reserved = "RESERVED"
    case cancelledEmployee = "CANCELLED_EMPLOYEE"
    case cancelledCustomer = "CANCELLED_CUSTOMER"
    case done = "DONE"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = AppointmentStatus(rawValue: rawValue) ?? .unknown
    }
}
