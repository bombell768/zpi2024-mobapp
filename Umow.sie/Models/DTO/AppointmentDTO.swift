//
//  Appointment.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 29/11/2024.
//

import Foundation

struct AppointmentDTO: Codable, Identifiable {
    let id: Int
    let date: Date
    let time: Time
    let status: AppointmentStatus
    let salonId: Int
    let employeeId: Int
    let customerId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "visitID"
        case date = "visitDate"
        case time = "visitStartTime"
        case status = "visitStatus"
        case salonId = "salonID"
        case employeeId = "employeeID"
        case customerId = "customerID"
    }
}


struct ServicesInAppointment: Codable {
    let id: Int
    let serviceId: Int
    let visitId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "serviceInVisitId"
        case serviceId = "serviceID"
        case visitId = "visitID"
    }
}
