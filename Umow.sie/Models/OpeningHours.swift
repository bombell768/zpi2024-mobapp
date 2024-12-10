//
//  OpeningHours.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 19/11/2024.
//

import Foundation

struct OpeningHours: Codable {
    let id: Int
    var weekday: Int
    var calendarWeekday: Int
    var openingHour: Time
    var closingHour: Time
    var salon: Salon
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.weekday = try container.decode(Int.self, forKey: .weekday)
        self.openingHour = try container.decode(Time.self, forKey: .openingHour)
        self.closingHour = try container.decode(Time.self, forKey: .closingHour)
        self.salon = try container.decode(Salon.self, forKey: .salon)
        
        switch self.weekday {
        case 1: self.calendarWeekday = 2
        case 2: self.calendarWeekday = 3
        case 3: self.calendarWeekday = 4
        case 4: self.calendarWeekday = 5
        case 5: self.calendarWeekday = 6
        case 6: self.calendarWeekday = 7
        case 7: self.calendarWeekday = 1
        default: self.calendarWeekday = self.weekday
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "openingHoursID"
        case weekday
        case openingHour
        case closingHour
        case salon = "salonModel"
    }
    
    func dayName() -> String {
        let days = ["Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"]
        return days[weekday - 1]
    }
    
    func formattedHours() -> String {
        "\(openingHour.formattedToMinutes()) - \(closingHour.formattedToMinutes())"
    }
}
