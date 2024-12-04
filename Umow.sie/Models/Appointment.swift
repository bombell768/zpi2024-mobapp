//
//  Appointment.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

@Observable class Appointment: Identifiable, Equatable {
    static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        return lhs.id == rhs.id &&
               lhs.date == rhs.date &&
               lhs.time == rhs.time &&
               lhs.status == rhs.status &&
               lhs.salon == rhs.salon &&
               lhs.employee == rhs.employee &&
               lhs.services == rhs.services &&
               lhs.isRated == rhs.isRated
    }
    
    let id: Int
    var date: Date
    var time: Time
    var status: AppointmentStatus
    var salon: Salon
    var employee: Employee
    var services: [Service]
    var isRated: Bool
    
    init(id: Int, date: Date, time: Time, status: AppointmentStatus, salon: Salon, employee: Employee, services: [Service], isRated: Bool) {
        self.id = id
        self.date = date
        self.time = time
        self.status = status
        self.salon = salon
        self.employee = employee
        self.services = services
        self.isRated = isRated
    }
}


enum AppointmentStatus: String, Codable, Equatable {
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
