//
//  TimeSlot.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import Foundation

struct TimeSlot: Codable, Equatable, Hashable {
    var date: Date
    var time: Time
    var employeeId: Int
    
    init(date: Date, time: Time, employeeId: Int) {
        self.date = date
        self.time = time
        self.employeeId = employeeId
    }
    
    init(){
        date = Date()
        time = Time(hour: 0, minute: 0, second: 0)
        employeeId = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "timeSlotDate"
        case time = "timeSlotTime"
        case employeeId = "employeeID"
    }
    
    static func == (lhs: TimeSlot, rhs: TimeSlot) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(lhs.date, equalTo: rhs.date, toGranularity: .day) &&
               lhs.time == rhs.time &&
               lhs.employeeId == rhs.employeeId
    }
}
