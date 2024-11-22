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
    

}
