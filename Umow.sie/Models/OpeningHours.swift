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
    var openingHour: Time
    var closingHour: Time
    var salon: Salon
}
