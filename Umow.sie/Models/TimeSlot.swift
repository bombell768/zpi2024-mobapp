//
//  TimeSlot.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import Foundation

struct TimeSlot: Codable {
    var date: Date
    var time: Time
    var employee: Employee
}
