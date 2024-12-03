//
//  Rating.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 03/12/2024.
//

import Foundation

struct Rating: Identifiable {
    let id: Int
    var rating: Double
    var description: String
    var employee: Employee
    var services: [Service]
    var client: Client
  
}
